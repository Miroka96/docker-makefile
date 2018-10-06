# https://github.com/Miroka96/docker-makefile

NAME = container-name
TAG = 1.0

VOLUME = container-data
MOUNTPATH = /data

# if you want a special image name, edit this
IMAGE = $(NAME):$(TAG)

# if you have no volume, comment the following line
VOLUMEMOUNTING = -v $(VOLUME):$(MOUNTPATH)

.PHONY: build-container test-container build-test-container deploy-container build-deploy-container undeploy-container redeploy-container build-redeploy-container clean-volume clean-container clean install-dependencies configure

build-container:
	docker build -t $(IMAGE) .

test-container:
	docker run $(VOLUMEMOUNTING) --rm $(IMAGE)

build-test-container: build-container test-container

deploy-container:
	docker run --detach --restart always --name=$(NAME) $(VOLUMEMOUNTING) $(IMAGE)

build-deploy-container: build-container deploy-container

undeploy-container:
	-docker stop $(NAME)
	docker rm $(NAME)

redeploy-container: undeploy-container deploy-container

build-redeploy-container: build-container redeploy-container

clean-volume:
	-docker volume rm $(VOLUME)

clean-container:
	-docker rm $(NAME)

clean: clean-volume clean-container

install-dependencies:
	echo No dependencies yet

configure:
	echo No configuration yet