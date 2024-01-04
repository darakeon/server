main: ubuntu netcore netcore_server server netcore_libman

main_push: ubuntu_push netcore_push netcore_server_push server_push netcore_libman_push


alpine:
	@make single MACHINE=alpine CONTEXT=.

alpine_push: alpine
	@make push MACHINE=alpine


ubuntu:
	@make single MACHINE=ubuntu CONTEXT=.

ubuntu_push: ubuntu
	@make push MACHINE=ubuntu


dockery:
	@make single MACHINE=dockery CONTEXT=.

dockery_push: dockery
	@make push MACHINE=dockery


netcore:
	@make single MACHINE=netcore CONTEXT=.

netcore_push: netcore
	@make push MACHINE=netcore


netcore_libman:
	@make single MACHINE=netcore-libman CONTEXT=.

netcore_libman_push: netcore_libman
	@make push MACHINE=netcore-libman


netcore_server:
	@make single MACHINE=netcore-server CONTEXT=.

netcore_server_push: netcore_server
	@make push MACHINE=netcore-server


server:
	@make single MACHINE=server CONTEXT=..

server_push: server
	@make push MACHINE=server


aws:
	@make single MACHINE=aws CONTEXT=.

aws_push: aws
	@make push MACHINE=aws


aws_terraform:
	@make single MACHINE=aws-terraform CONTEXT=.

aws_terraform_push: aws_terraform
	@make push MACHINE=aws-terraform


talisman:
	@make single MACHINE=talisman CONTEXT=.

talisman_push: talisman
	@make push MACHINE=talisman


single:
	@echo "Building ${MACHINE}..."
	@docker build ${CONTEXT} --pull --progress plain -f images/${MACHINE}.dockerfile -t darakeon/${MACHINE} --network=host
	@echo "${MACHINE} built!"


push:
	@echo "Pushing ${MACHINE}..."
	@docker push darakeon/${MACHINE}
	@echo "${MACHINE} pushed!"
