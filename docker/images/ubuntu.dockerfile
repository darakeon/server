FROM ubuntu
LABEL maintainer="Dara Keon <laboon@darakeon.com>"

RUN echo '#!/bin/bash' > /bin/maintain
RUN echo 'date' >> /bin/maintain
RUN echo 'apt-get upgrade -y' >> /bin/maintain
RUN echo 'apt-get update' >> /bin/maintain
RUN echo 'apt-get autoremove -y' >> /bin/maintain
RUN echo 'apt-get clean' >> /bin/maintain
RUN chmod +x /bin/maintain

RUN echo '#!/bin/bash' > /bin/ci_stop
RUN echo 'circleci-agent step halt' >> /bin/ci_stop
RUN chmod +x /bin/ci_stop

RUN maintain

RUN apt-get install -y curl nano zip unzip

RUN echo 'export PS1="\n\n[\[\033[01;30m\]\A\[\033[00m\]] \[\033[01;31m\]\u\[\033[00m\]@\[\033[01;35m\]\W\[\033[00m\]$ "' >> ~/.bashrc

RUN echo "printf '\e[38;5;217m'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~ Welcome! This Ubuntu has curl, nano, zip and unzip installed ~~~~~~~~~'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ by Dara Keon ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc

CMD bash
