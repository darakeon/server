FROM darakeon/nginx-netcore
MAINTAINER Dara Keon
RUN apt upgrade -y && apt update && apt autoremove -y

RUN apt install -y certbot python3-certbot-nginx
RUN mkdir /var/log/letsencrypt
COPY docker/default.conf /etc/nginx/conf.d/

COPY tls /var/tls
RUN dotnet publish /var/tls/TLS.csproj -o /var/www
RUN apt remove -y dotnet-sdk-5.0
RUN rm -r /var/tls

ENV ASPNETCORE_URLS=http://+:1986
EXPOSE 80
EXPOSE 443

WORKDIR /var/www

CMD service nginx start && ./TLS
