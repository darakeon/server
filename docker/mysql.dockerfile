FROM ubuntu
MAINTAINER Dara Keon
RUN apt update

RUN apt install -y mysql-server
RUN usermod -d /var/lib/mysql/ mysql
RUN update-rc.d mysql enable

CMD service mysql start && bash
