# https://github.com/Miroka96/docker-makefile

NAME = container-name
TAG = 1.0
IMAGE = $(NAME):$(TAG)
VOLUME = container-data
MOUNTPATH = /data

.PHONY: build-container test-container build-test-container deploy-container build-deploy-container undeploy-container redeploy-container build-redeploy-container clean install-dependencies configure

build-container:
	docker build -t $(IMAGE) .

test-container:
	docker run -v $(VOLUME):$(MOUNTPATH) --rm $(IMAGE)

build-test-container: build-container test-container

deploy-container:
	docker run --detach --restart always --name=$(NAME) -v $(VOLUME):$(MOUNTPATH) $(IMAGE)

build-deploy-container: build-container deploy-container

undeploy-container:
	-docker stop $(NAME)
	docker rm $(NAME)

redeploy-container: undeploy-container deploy-container

build-redeploy-container: build-container redeploy-container

clean:
	-docker volume rm $(VOLUME)
	-docker rm $(NAME)

install-dependencies:
	echo No dependencies yet

configure:
	echo Create a configuration script and edit this to: sh configure.sh
