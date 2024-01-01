FROM darakeon/netcore as builder
LABEL maintainer="Dara Keon <laboon@darakeon.com>"
RUN maintain

COPY tls /var/tls
RUN dotnet publish /var/tls/TLS.csproj -o /var/www


FROM darakeon/netcore-server

COPY --from=builder /var/www /var/www

RUN apt-get install -y nginx

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get install -y certbot python3-certbot-nginx
RUN mkdir /var/log/letsencrypt
COPY docker/nginx/default.conf /etc/nginx/conf.d/
COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf

ENV ASPNETCORE_URLS=http://+:1986
EXPOSE 80
EXPOSE 443

WORKDIR /var/www

CMD service nginx start && ./TLS || echo 'TLS DID NOT RUN' && tail -f /dev/null
