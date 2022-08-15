FROM darakeon/ubuntu
LABEL maintainer="Dara Keon <laboon@darakeon.com>"
RUN maintain

RUN apt-get install -y ca-certificates
RUN V=$(cat /etc/issue | sed s/[^0-9\.]//g) \
	&& echo ${V} \
	&& URL=https://packages.microsoft.com/config/ubuntu/${V}/packages-microsoft-prod.deb \
	&& curl ${URL} > packages-microsoft-prod.deb \
	&& dpkg -i packages-microsoft-prod.deb \
	&& rm packages-microsoft-prod.deb

RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN apt-get install -y dotnet-sdk-6.0
RUN apt-get install -y aspnetcore-runtime-6.0

RUN echo "echo" >> ~/.bashrc
RUN echo "printf '\e[38;5;46m'" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "echo ------------------------------------ DOTNET ------------------------------------" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "printf '\e[38;5;51m'" >> ~/.bashrc
RUN echo "dotnet --info" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc
