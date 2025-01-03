FROM darakeon/alpine
LABEL maintainer="Dara Keon <laboon@darakeon.com>"

ARG NETCORE="8"
ENV NETCORE=$NETCORE

RUN apk add bash icu-libs krb5-libs libgcc libintl libstdc++ zlib \
    && curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh \
    && chmod +x ./dotnet-install.sh \
    && ./dotnet-install.sh --channel ${NETCORE}.0 --install-dir /usr/lib/dotnet --runtime aspnetcore \
    && rm ./dotnet-install.sh

ENV DOTNET_ROOT=/usr/lib/dotnet
ENV DOTNET_NOLOGO=1
ENV PATH=${PATH}:${DOTNET_ROOT}:${DOTNET_ROOT}/tools

RUN apk add --no-cache icu-libs icu-data-full
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false

RUN echo "echo" >> ~/.bashrc
RUN echo "printf '\e[38;5;46m'" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "echo -------------------------------- DOTNET RUNTIME --------------------------------" >> ~/.bashrc
RUN echo "echo --------------------------------------------------------------------------------" >> ~/.bashrc
RUN echo "printf '\e[38;5;51m'" >> ~/.bashrc
RUN echo "dotnet --info" >> ~/.bashrc
RUN echo "printf '\e[38;5;253m'" >> ~/.bashrc
