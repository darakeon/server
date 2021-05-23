FROM darakeon/aws
LABEL maintainer="Dara Keon <laboon@darakeon.com>"

RUN curl "https://www.terraform.io/downloads.html" | \
	grep "https://releases.hashicorp.com/terraform/" | \
	grep "_linux_amd64.zip" | \
	cut -d'"' -f 2 | \
	xargs curl -o terraform.zip

RUN unzip terraform.zip -d /usr/bin
RUN rm terraform.zip

RUN echo "echo" >> ~/.bashrc
RUN echo "printf '\e[38;5;46m'" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "echo --------------------------- TERRAFORM \(is not plain\) ---------------------------" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "printf '\e[38;5;51m'" >> ~/.bashrc
RUN echo "terraform --version" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc
