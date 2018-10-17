# https://github.com/Miroka96/docker-makefile

NAME = miroka96/container-name
TAG = 1.0

# either use volume name or absolute host path, eventually use ${PWD} for the current working directory
VOLUME = container-data
MOUNTPATH = /data

LOCALPORT = 8080
CONTAINERPORT = 80

# if you want a special image name, edit this
IMAGE = $(NAME):$(TAG)

# if you have no volume, delete the right part
VOLUMEMOUNTING = -v $(VOLUME):$(MOUNTPATH)

# if you publish no ports, delete the right part
PORTPUBLISHING = -p $(LOCALPORT):$(CONTAINERPORT)

.PHONY: build test test-shell build-test deploy build-deploy undeploy redeploy build-redeploy clean-volume clean-container clean install-dependencies configure

build:
	docker build -t $(IMAGE) .

build-nocache:
	docker build -t $(IMAGE) --no-cache .

test:
	docker run $(VOLUMEMOUNTING) $(PORTPUBLISHING) --rm $(IMAGE)

test-shell:
	docker run $(VOLUMEMOUNTING) $(PORTPUBLISHING) -it --rm $(IMAGE) /bin/bash

build-test: build test

deploy:
	docker run --detach --restart always --name=$(NAME) $(VOLUMEMOUNTING) $(PORTPUBLISHING) $(IMAGE)

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
