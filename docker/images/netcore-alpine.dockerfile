FROM darakeon/alpine
LABEL maintainer="Dara Keon <laboon@darakeon.com>"

RUN apk add bash icu-libs krb5-libs libgcc libintl libstdc++ zlib \
    && curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh \
    && chmod +x ./dotnet-install.sh \
    && ./dotnet-install.sh --channel 8.0 --install-dir /usr/lib/dotnet \
    && rm ./dotnet-install.sh

ENV DOTNET_ROOT=/usr/lib/dotnet
ENV DOTNET_NOLOGO=1
ENV PATH=${PATH}:${DOTNET_ROOT}:${DOTNET_ROOT}/tools

RUN echo "echo" >> ~/.bashrc
RUN echo "printf '\[\e[38;5;46m\]'" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "echo ------------------------------------ DOTNET ------------------------------------" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "printf '\[\e[38;5;51m\]'" >> ~/.bashrc
RUN echo "dotnet --info" >> ~/.bashrc
RUN echo "printf '\[\e[38;5;253m\]'" >> ~/.bashrc
