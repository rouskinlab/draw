DOCKER_IMAGE := ydmt/dreem
VERSION := $(shell git describe --always --dirty --long)
PYPI_PASSWORD := $(shell cat ~/.pypi_pass.txt)

default: 
	python setup.py install

pytest:
	pytest test -v

init:
	pip install -r requirements.txt

build-image:
	docker build .
		-f ./Dockerfile
		-t $(DOCKER_IMAGE):$(VERSION)

push-image:
	docker push $(DOCKER_IMAGE):$(VERSION)

upgrade-dependencies:
	pip uninstall -y seismic-graph
	rm -f requirements.txt
	pip freeze > requirements.txt
	python setup.py install

push_to_pypi:
	rm -fr dist
	python3 -m build
	twine upload -r pypi dist/* --user yvesmartindestaillades --password $(PYPI_PASSWORD)
	rm -fr dist

docs_update:
	rm -rf docs/_*
	rm -rf docs/.doctrees
	rm -rf docs/*.html
	rm -rf docs/*.inv
	rm -rf docs/*.js
	sphinx-build docs/source docs/build docs/* -b html

docs_clear:
	rm -rf docs/_*
	rm -rf docs/.doctrees
	rm -rf docs/*.html
	rm -rf docs/*.inv
	rm -rf docs/*.js
