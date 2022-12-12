FROM darakeon/ubuntu
LABEL maintainer="Dara Keon <laboon@darakeon.com>"
RUN maintain

RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN apt-get install -y dotnet-sdk-6.0
RUN apt-get install -y aspnetcore-runtime-6.0

ENV DOTNET_ROOT=/usr/lib/dotnet

RUN echo "echo" >> ~/.bashrc
RUN echo "printf '\e[38;5;46m'" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "echo ------------------------------------ DOTNET ------------------------------------" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "printf '\e[38;5;51m'" >> ~/.bashrc
RUN echo "dotnet --info" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc
