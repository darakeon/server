MAKEFLAGS += --no-print-directory
CONTEXT=.
NETCORE=8


main: ubuntu netcore_alpine netcore_server server netcore_libman_alpine

main_push: ubuntu_push netcore_alpine_push netcore_server_push server_push netcore_libman_alpine_push


alpine:
	@make single MACHINE=alpine

alpine_push: alpine
	@make push MACHINE=alpine


ubuntu:
	@make single MACHINE=ubuntu

ubuntu_push: ubuntu
	@make push MACHINE=ubuntu


dockery:
	@make single MACHINE=dockery

dockery_push: dockery
	@make push MACHINE=dockery


netcore_alpine:
	@make single MACHINE=netcore DISTRO=alpine TAG=alpine-net${NETCORE}

netcore_alpine_push: netcore_alpine
	@make push MACHINE=netcore DISTRO=alpine TAG=alpine-net${NETCORE}


netcore_ubuntu:
	@make single MACHINE=netcore DISTRO=ubuntu TAG=ubuntu-net${NETCORE}

netcore_ubuntu_push: netcore_ubuntu
	@make push MACHINE=netcore DISTRO=ubuntu TAG=ubuntu-net${NETCORE}


netcore_libman_alpine:
	@make single MACHINE=netcore-libman DISTRO=alpine TAG=alpine-net${NETCORE}

netcore_libman_alpine_push: netcore_libman_alpine
	@make push MACHINE=netcore-libman DISTRO=alpine TAG=alpine-net${NETCORE}


netcore_libman_ubuntu:
	@make single MACHINE=netcore-libman DISTRO=ubuntu TAG=ubuntu-net${NETCORE}

netcore_libman_ubuntu_push: netcore_libman_ubuntu
	@make push MACHINE=netcore-libman DISTRO=ubuntu TAG=ubuntu-net${NETCORE}


netcore_server:
	@make single MACHINE=netcore-server TAG=net${NETCORE}

netcore_server_push: netcore_server
	@make push MACHINE=netcore-server TAG=net${NETCORE}


server:
	@make single MACHINE=server CONTEXT=..

server_push: server
	@make push MACHINE=server


aws:
	@make single MACHINE=aws

aws_push: aws
	@make push MACHINE=aws


aws_terraform:
	@make single MACHINE=aws-terraform

aws_terraform_push: aws_terraform
	@make push MACHINE=aws-terraform


talisman:
	@make single MACHINE=talisman

talisman_push: talisman
	@make push MACHINE=talisman


github_cli:
	@make single MACHINE=github-cli

github_cli_push: github_cli
	@make push MACHINE=github-cli


single:
	@echo "Building ${MACHINE}$(if ${DISTRO}, ${DISTRO},)..."
	@docker build ${CONTEXT} --progress plain \
		-f images/${MACHINE}$(if ${DISTRO},-${DISTRO},).dockerfile \
		-t darakeon-${MACHINE}$(if ${DISTRO},-${DISTRO},) \
		--build-arg NETCORE=${NETCORE} \
		--network=host
	@docker tag darakeon-${MACHINE}$(if ${DISTRO},-${DISTRO},) \
		darakeon/${MACHINE}$(if ${DISTRO},:${DISTRO},)
	@if [ "${DISTRO}" = "alpine" ]; then \
		docker tag darakeon-${MACHINE}$(if ${DISTRO},-${DISTRO},) darakeon/${MACHINE}; \
	fi
	@if [ "${TAG}" != "" ]; then \
		docker tag darakeon-${MACHINE}$(if ${DISTRO},-${DISTRO},) darakeon/${MACHINE}:${TAG}; \
	fi
	@echo "${MACHINE}$(if ${DISTRO}, ${DISTRO},) built!"


push:
	@echo "Pushing ${MACHINE}$(if ${DISTRO}, ${DISTRO},)..."
	@docker push darakeon/${MACHINE}$(if ${DISTRO},:${DISTRO},)
	@if [ "${DISTRO}" = "alpine" ]; then \
		docker push darakeon/${MACHINE}; \
	fi
	@if [ "${TAG}" != "" ]; then \
		docker push darakeon/${MACHINE}:${TAG}; \
	fi
	@echo "${MACHINE}$(if ${DISTRO}, ${DISTRO},) pushed!"
