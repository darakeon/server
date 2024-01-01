FROM darakeon/aws
LABEL maintainer="Dara Keon <laboon@darakeon.com>"

RUN apt-get install -y gpg \
	&& curl -sL https://apt.releases.hashicorp.com/gpg | \
		gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg\
	&& . /etc/os-release \
	&& echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $VERSION_CODENAME main" > /etc/apt/sources.list.d/hashicorp.list\
	&& apt-get update -y && apt-get install -y terraform \
	&& clean_os

RUN echo "echo" >> ~/.bashrc
RUN echo "printf '\e[38;5;46m'" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "echo --------------------------- TERRAFORM \(is not plain\) ---------------------------" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "printf '\e[38;5;51m'" >> ~/.bashrc
RUN echo "terraform --version" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc
