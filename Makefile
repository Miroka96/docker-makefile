# https://github.com/Miroka96/docker-makefile

AUTHOR = miroka96
NAME = container-name
TAG = 1.0

# if you want a special image name, edit this
IMAGE = $(AUTHOR)/$(NAME):$(TAG)

# either use volume name or absolute host path, eventually use ${PWD} for the current working directory
VOLUME = container-data
MOUNTPATH = /data

# if you have no volume, delete the right part
VOLUMEMOUNTING = -v $(VOLUME):$(MOUNTPATH)

LOCALPORT = 8080
CONTAINERPORT = 80

# if you publish no ports, delete the right part
PORTPUBLISHING = -p $(LOCALPORT):$(CONTAINERPORT)

OTHER_CONTAINER_NAME = my_mysql
OTHER_CONTAINER_ALIAS = mysql

# if you do not link another container, delete the right part
CONTAINERLINKING = --link $(OTHER_CONTAINER_NAME):$(OTHER_CONTAINER_ALIAS)

# if you do not need to set environment variables, delete the right part
ENVIRONMENT = -e DEBUG=false

# if you do not need to set CLI parameters for the executed program, delete the right part
CLI_PARAMETERS =

# if you do not need to set debug CLI parameters for the executed program, delete the right part
CLI_DEBUG_PARAMETERS =

DOCKERPARAMETERS = $(VOLUMEMOUNTING) $(PORTPUBLISHING) $(CONTAINERLINKING) $(ENVIRONMENT)

.PHONY: build test test-shell build-test deploy build-deploy undeploy redeploy build-redeploy clean-volume clean-container clean install-dependencies configu$

build:
        docker build -t $(IMAGE) .

build-nocache:
        docker build -t $(IMAGE) --no-cache .

test:
        docker run $(DOCKERPARAMETERS) --rm $(IMAGE) $(CLI_PARAMETERS) $(CLI_DEBUG_PARAMETERS)

test-shell:
        docker run $(DOCKERPARAMETERS) -it --rm $(IMAGE) /bin/bash

build-test: build test

deploy:
        docker run --detach --restart always --name=$(NAME) $(DOCKERPARAMETERS) $(IMAGE) $(CLI_PARAMETERS)

build-deploy: build deploy

undeploy:
        -docker stop $(NAME)
        docker rm $(NAME)

redeploy: undeploy deploy

build-redeploy: build redeploy

clean-volume:
        -docker volume rm $(VOLUME)

clean-container:
        -docker rm $(NAME)

clean: clean-volume clean-container
