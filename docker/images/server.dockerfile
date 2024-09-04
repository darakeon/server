FROM darakeon/netcore as builder
LABEL maintainer="Dara Keon <laboon@darakeon.com>"

RUN maintain

COPY tls /var/tls
RUN dotnet publish /var/tls/TLS.csproj -o /var/www


FROM darakeon/netcore-server
LABEL maintainer="Dara Keon <laboon@darakeon.com>"

COPY --from=builder /var/www /var/www

RUN apk add nginx

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apk add certbot certbot-nginx
RUN mkdir /var/log/letsencrypt
COPY docker/nginx/*.conf /etc/nginx/conf.d/
RUN mv /etc/nginx/conf.d/nginx.conf /etc/nginx/nginx.conf
COPY docker/images/scripts/alpine_nginx_and_tls /var/www/nginx_and_tls
RUN chmod +x /var/www/nginx_and_tls

COPY docker/nginx/maintenance /var/www

RUN adduser --system --no-create-home --shell /bin/false www-data

ENV ASPNETCORE_URLS=http://+:1986
EXPOSE 80
EXPOSE 443

WORKDIR /var/www

CMD ./nginx_and_tls
