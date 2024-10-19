FROM darakeon/ubuntu
LABEL maintainer="Dara Keon <laboon@darakeon.com>"

RUN curl -fsSL https://get.docker.com -o get-docker.sh \
    && chmod +x get-docker.sh \
    && ./get-docker.sh \
    && clean_os

RUN echo "echo" >> ~/.bashrc
RUN echo "printf '\[\e[38;5;46m\]'" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "echo ------------------------------------ DOCKER ------------------------------------" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "printf '\[\e[38;5;51m\]'" >> ~/.bashrc
RUN echo "docker --version" >> ~/.bashrc
RUN echo "printf '\[\e[38;5;253m\]'" >> ~/.bashrc
