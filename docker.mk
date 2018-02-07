DOCKER_USER ?= $(shell basename `readlink -f ..`)
DOCKER_REPO ?= $(shell basename `readlink -f .`)
DOCKER_TAG ?= $(shell git describe --abbrev=0 --tags)
DOCKER_IMG ?= $(DOCKER_USER)/$(DOCKER_REPO):$(DOCKER_TAG)
DOCKER_PATH ?= .
DOCKER_BUILD_EXTRA ?= --pull

# Build a docker image.
docker-image:
	docker build -t $(DOCKER_IMG) $(DOCKER_BUILD_EXTRA) $(DOCKER_PATH)

# Push the docker image to Docker Hub.
docker-push:
	docker push $(DOCKER_IMG)
