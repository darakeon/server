all: alpine_push ubuntu_push netcore_push server_push

alpine:
	@make single MACHINE=alpine CONTEXT=.

alpine_push: alpine
	@make push MACHINE=alpine

ubuntu:
	@make single MACHINE=ubuntu CONTEXT=.

ubuntu_push: ubuntu
	@make push MACHINE=ubuntu

netcore:
	@make single MACHINE=netcore CONTEXT=.

netcore_push: netcore
	@make push MACHINE=netcore

server:
	@make single MACHINE=server CONTEXT=../..

server_push: server
	@make push MACHINE=server

single:
	@echo "Building ${MACHINE}..."
	@docker build ${CONTEXT} --pull --progress plain -f ../images/${MACHINE}.dockerfile -t darakeon/${MACHINE} --network=host
	@echo "${MACHINE} built!"

push:
	@echo "Pushing ${MACHINE}..."
	@docker push darakeon/${MACHINE}
	@echo "${MACHINE} pushed!"
