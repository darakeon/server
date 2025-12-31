FROM darakeon/alpine
LABEL maintainer="Dara Keon <laboon@darakeon.com>"

RUN apk add nginx

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY local/nginx/conf/* /etc/nginx/conf.d/

COPY docker/nginx/maintenance /var/www
COPY local/nginx/nginx /var/www
RUN chmod +x /var/www/nginx

RUN adduser --system --no-create-home --shell /bin/false www-data

EXPOSE 80
EXPOSE 443

WORKDIR /var/www

SHELL ["/bin/bash", "-c"]
CMD ./nginx
