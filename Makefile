.PHONY: clean data lint requirements  

#################################################################################
# VARIABLES                                                                       
#################################################################################

PROJECT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PROJECT_NAME = dash_app
BASE_CONTAINER = dash_app
USER_ID = $(shell id -u)
GROUP_ID = $(shell id -g)


#################################################################################
# Targets                                                                      
#################################################################################

init:
	# docker build --tag $(BASE_CONTAINER) --build-arg UID=$(USER_ID) --build-arg GID=$(GROUP_ID) .
	docker-compose build --build-arg UID=$(USER_ID) --build-arg GID=$(GROUP_ID) base

build:
	docker-compose build --build-arg UID=$(USER_ID) GID=$(GROUP_ID)

bash:
	docker-compose run app bash --init-file initfile

run:
	docker-compose up app

jupyter:
	docker-compose up jupyter

jupyter-log: jupyter-run
	docker logs $(BASE_CONTAINER)_jupyter

## Delete all compiled Python files
clean:
	find . -type f -name "*.py[co]" -delete
	find . -type d -name "__pycache__" -delete