FROM darakeon/ubuntu
LABEL maintainer="Dara Keon <laboon@darakeon.com>"
RUN maintain

RUN apt install -y libdigest-sha-perl

RUN apt install -y git
RUN git config --global init.templatedir /home/.git-template

RUN curl --silent https://raw.githubusercontent.com/thoughtworks/talisman/master/global_install_scripts/install.bash > /tmp/install_talisman.bash
RUN chmod +x /tmp/install_talisman.bash

# to avoid problem with tput 
ENV TERM=dumb
RUN echo "1\n\n/root" | /bin/bash /tmp/install_talisman.bash

RUN echo "echo" >> ~/.bashrc
RUN echo "printf '\e[38;5;46m'" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "echo ------------------------------- TALISMAN CHECKER -------------------------------" >> ~/.bashrc
RUN echo "echo ------   --------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "printf '\e[38;5;51m'" >> ~/.bashrc
RUN echo "talisman --version" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc

CMD bash
