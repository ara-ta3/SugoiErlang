run: bin/jupyter
	$< notebook

bin/jupyter: bin/pip
	$< install -r requirements.txt

bin/pip:
	$(MAKE) virtualenv

virtualenv:
	virtualenv -p python3 .
