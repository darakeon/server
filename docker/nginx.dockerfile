FROM nginx
MAINTAINER Dara Keon
RUN apt update

COPY nginx/*.sh /var/cert/
COPY nginx/default.conf /etc/nginx/conf.d/

RUN apt install -y certbot python3-certbot-nginx
RUN mkdir /var/log/letsencrypt

EXPOSE 80
EXPOSE 443
