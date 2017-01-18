FROM ubuntu:16.04
RUN apt-get update && apt-get install -y python3-dev python3-setuptools
RUN apt-get install -y erlang rebar
RUN apt-get install -y make curl gcc g++ wget
RUN git clone http://github.com/robbielynch/ierlang.git /opt/ierlang
RUN git clone http://github.com/zeromq/erlzmq2.git /opt/erlzmq2
RUN make -C /opt/erlzmq2
RUN make -C /opt/erlzmq2 docs
RUN make -C /opt/erlzmq2 test
RUN easy_install3 pip
RUN pip3 install jupyter
ENV ERL_LIBS /opt/erlzmq2:ERL_LIBS
ENV PATH $PATH:$ERL_LIBS
RUN pip3 install -r /opt/ierlang/requirements.txt
RUN patch /usr/local/lib/python3.5/dist-packages/IPython/kernel/zmq/session.py < /opt/ierlang/patches/ierlang.patch
RUN make -C /opt/ierlang compile
RUN mkdir -p /notebooks
EXPOSE 8888
# ENTRYPOINT ["tini", "--"]"--NotebookApp.port=8888", 
CMD ["jupyter", "notebook", "--no-browser", "--NotebookApp.notebook_dir=/notebooks"]
