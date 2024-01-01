FROM alpine
LABEL maintainer="Dara Keon <laboon@darakeon.com>"

COPY images/scripts/alpine_maintain /bin/maintain
RUN chmod +x /bin/maintain

COPY images/scripts/alpine_ci_stop /bin/ci_stop
RUN chmod +x /bin/ci_stop

RUN maintain

RUN apk add --no-cache --upgrade bash curl nano zip unzip

RUN echo 'export PS1="\n\n[\[\033[01;30m\]\A\[\033[00m\]] \[\033[01;31m\]\u\[\033[00m\]@\[\033[01;35m\]\W\[\033[00m\]$ "' >> ~/.bashrc

RUN echo "printf '\e[38;5;217m'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "echo '~~~~~~ Welcome! This Alpine has bash, curl, nano, zip and unzip installed ~~~~~~'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ by Dara Keon ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc

CMD bash
