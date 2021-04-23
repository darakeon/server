FROM ubuntu:20.04
MAINTAINER Dara Keon

RUN echo '#!/bin/bash' > /bin/maintain
RUN echo 'apt upgrade -y' >> /bin/maintain
RUN echo 'apt update' >> /bin/maintain
RUN echo 'apt autoremove -y' >> /bin/maintain
RUN echo 'apt clean' >> /bin/maintain
RUN chmod +x /bin/maintain

RUN echo '#!/bin/bash' > /bin/ci_stop
RUN echo 'circleci-agent step halt' >> /bin/ci_stop
RUN chmod +x /bin/ci_stop

RUN maintain

RUN apt install -y curl nano unzip

RUN echo 'export PS1="\n\n[\A] \u@\W\$ "' >> ~/.bashrc

RUN echo "printf '\e[38;5;217m'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~ Welcome, this Ubuntu has curl, nano and unzip installed! ~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ by Dara Keon ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc

CMD bash
