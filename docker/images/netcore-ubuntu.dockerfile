FROM darakeon/ubuntu
LABEL maintainer="Dara Keon <laboon@darakeon.com>"

ARG NETCORE="8"
ENV NETCORE=$NETCORE

RUN apt-get install -y \
        libc6 libgcc1 libgcc-s1 libgssapi-krb5-2 libicu74 \
        liblttng-ust1 libssl3 libstdc++6 libunwind8 zlib1g \
    && curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh \
    && chmod +x ./dotnet-install.sh \
    && ./dotnet-install.sh --channel ${NETCORE}.0 --install-dir /usr/lib/dotnet \
    && rm ./dotnet-install.sh \
    && clean_os

ENV DOTNET_ROOT=/usr/lib/dotnet
ENV DOTNET_NOLOGO=1
ENV PATH=${PATH}:${DOTNET_ROOT}:${DOTNET_ROOT}/tools

RUN echo "echo" >> ~/.bashrc
RUN echo "printf '\e[38;5;46m'" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "echo ------------------------------------ DOTNET ------------------------------------" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "printf '\e[38;5;51m'" >> ~/.bashrc
RUN echo "dotnet --info" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc
