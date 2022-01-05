FROM darakeon/ubuntu
LABEL maintainer="Dara Keon <laboon@darakeon.com>"
RUN maintain

RUN apt install -y ca-certificates
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb > packages-microsoft-prod.deb \
	&& dpkg -i packages-microsoft-prod.deb \
	&& rm packages-microsoft-prod.deb

RUN apt update
RUN apt install -y apt-transport-https
RUN apt install -y dotnet-sdk-6.0
RUN apt install -y aspnetcore-runtime-6.0

RUN echo "echo" >> ~/.bashrc
RUN echo "printf '\e[38;5;46m'" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "echo ------------------------------------ DOTNET ------------------------------------" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "printf '\e[38;5;51m'" >> ~/.bashrc
RUN echo "dotnet --info" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc
