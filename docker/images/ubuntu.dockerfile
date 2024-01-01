FROM ubuntu
LABEL maintainer="Dara Keon <laboon@darakeon.com>"

COPY images/scripts/ubuntu_maintain /bin/maintain
RUN chmod +x /bin/maintain

COPY images/scripts/ubuntu_clean_os /bin/clean_os
RUN chmod +x /bin/clean_os

COPY images/scripts/ubuntu_ci_stop /bin/ci_stop
RUN chmod +x /bin/ci_stop

RUN maintain

RUN apt-get install -y \
        curl nano zip unzip git build-essential \
    && clean_os

RUN echo 'export PS1="\n\n[\[\033[01;30m\]\A\[\033[00m\]] \[\033[01;31m\]\u\[\033[00m\]@\[\033[01;35m\]\W\[\033[00m\]$ "' >> ~/.bashrc

RUN echo "printf '\e[38;5;217m'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~~ Welcome! This Ubuntu has installed ~~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~ curl, nano, zip, unzip, git and make ~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ by Dara Keon ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc

RUN echo "echo" >> ~/.bashrc
RUN echo "printf '\e[38;5;46m'" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "echo ------------------------------------ UBUNTU ------------------------------------" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "printf '\e[38;5;51m'" >> ~/.bashrc
RUN echo "cat /etc/issue" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc

CMD bash
