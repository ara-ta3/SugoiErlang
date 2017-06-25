FROM ubuntu:16.04
RUN apt-get update && apt-get install -y python3-dev python3-setuptools python3-venv
RUN apt-get install -y erlang rebar
RUN apt-get install -y make curl gcc g++ wget
RUN git clone http://github.com/robbielynch/ierlang.git /opt/ierlang
RUN git clone http://github.com/zeromq/erlzmq2.git /opt/erlzmq2
RUN make -C /opt/erlzmq2
RUN make -C /opt/erlzmq2 docs
RUN make -C /opt/erlzmq2 test
RUN easy_install3 pip
RUN python3 -m venv /opt/python3
RUN . /opt/python3/bin/activate && pip install jupyter ipython
ENV ERL_LIBS /opt/erlzmq2:ERL_LIBS
ENV PATH $PATH:$ERL_LIBS
RUN . /opt/python3/bin/activate && pip install -r /opt/ierlang/requirements.txt
RUN patch /opt/python3/lib/python3.5/site-packages/IPython/kernel/zmq/session.py < /opt/ierlang/patches/ierlang.patch
RUN make -C /opt/ierlang compile
RUN mkdir -p /notebooks
EXPOSE 8888
# ENTRYPOINT ["tini", "--"]"--NotebookApp.port=8888", 
CMD ["." "/opt/python3/bin/activate", "&&", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--NotebookApp.notebook_dir=/notebooks"]
