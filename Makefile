NAME = moekiwisama/envready
VERSION = 0.0.1

.PHONY: build start push

build:
	docker build -t ${NAME}:${VERSION} --build-arg proxy_commands=${PROXY_COMMANDS} .

tag-latest:
	docker tag ${NAME}:${VERSION} ${NAME}:latest

start:
	docker run -it --rm ${NAME}:${VERSION}

push: build tag-latest
	docker push ${NAME}:${VERSION}; docker push ${NAME}:latest
