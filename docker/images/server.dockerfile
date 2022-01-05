FROM darakeon/netcore
LABEL maintainer="Dara Keon <laboon@darakeon.com>"
RUN maintain

RUN apt-get install -y nginx

RUN apt-get install -y certbot python3-certbot-nginx
RUN mkdir /var/log/letsencrypt
COPY docker/nginx/default.conf /etc/nginx/conf.d/
COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf

COPY tls /var/tls
RUN dotnet publish /var/tls/TLS.csproj -o /var/www
RUN apt-get remove -y dotnet-sdk-6.0
RUN rm -r /var/tls

ENV ASPNETCORE_URLS=http://+:1986
EXPOSE 80
EXPOSE 443

WORKDIR /var/www

CMD service nginx start && ./TLS
