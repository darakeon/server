FROM darakeon/ubuntu
MAINTAINER Dara Keon
RUN maintain

RUN apt install -y ca-certificates
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb > packages-microsoft-prod.deb \
	&& dpkg -i packages-microsoft-prod.deb \
	&& rm packages-microsoft-prod.deb

RUN apt update
RUN apt install -y apt-transport-https
RUN apt install -y dotnet-sdk-5.0
RUN apt install -y aspnetcore-runtime-5.0
