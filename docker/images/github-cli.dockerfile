FROM darakeon/alpine
LABEL maintainer="Dara Keon <laboon@darakeon.com>"

RUN maintain

RUN apk add github-cli

#(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
#&& sudo mkdir -p -m 755 /etc/apt/keyrings \
#&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
#&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
#&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
#&& sudo apt update \
#&& sudo apt install gh -y

RUN echo "echo" >> ~/.bashrc
RUN echo "printf '\e[38;5;46m'" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "echo ---------------------------------- GITHUB CLI ----------------------------------" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "printf '\e[38;5;51m'" >> ~/.bashrc
RUN echo "gh version" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc

RUN apk add --update --no-cache python3

RUN echo "echo" >> ~/.bashrc
RUN echo "printf '\e[38;5;46m'" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "echo ------------------------------------ PYTHON ------------------------------------" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "printf '\e[38;5;51m'" >> ~/.bashrc
RUN echo "python --version" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc
