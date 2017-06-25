docker_image_name=ierlang
PORT=8080
file=chap1.erl

run:
	./$(file)

run/jupyter: bin/jupyter
	$< notebook

bin/jupyter: bin/pip
	$< install -r requirements.txt

bin/pip:
	$(MAKE) virtualenv

virtualenv:
	virtualenv -p python3 .

docker/run:
	docker run -it --volume $(PWD):/notebooks -p 8888:8888 $(docker_image_name)

docker/build:
	docker build . -t $(docker_image_name)

