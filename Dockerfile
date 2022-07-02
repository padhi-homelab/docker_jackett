FROM padhihomelab/debian-base:11.3_0.19.0_git.212b7514 as base
ARG TARGETARCH

FROM base AS base-amd64
ENV JACKETT_ARCH=AMDx64

FROM base AS base-arm64
ENV JACKETT_ARCH=ARM64

FROM base AS base-armv7
ENV JACKETT_ARCH=ARM32

FROM base-${TARGETARCH}${TARGETVARIANT}


ARG JACKETT_VERSION=0.20.1263


ADD "https://github.com/Jackett/Jackett/releases/download/v${JACKETT_VERSION}/Jackett.Binaries.Linux${JACKETT_ARCH}.tar.gz" \
    /tmp/jackett.tar.gz


COPY jackett.sh \
     /usr/local/bin/jackett
COPY entrypoint-scripts \
     /etc/docker-entrypoint.d/99-extra-scripts


RUN chmod +x /etc/docker-entrypoint.d/99-extra-scripts/*.sh \
             /usr/local/bin/jackett \
 && cd /tmp \
 && tar -xvzf jackett.tar.gz \
 && rm -rf Jackett/JackettUpdater* \
           /tmp/jackett.tar.gz \
 && mv /tmp/Jackett /jackett \
 && apt update \
 && apt install -yq libicu67 \
                    ca-certificates \
                    tzdata \
                    wget \
 && apt autoremove -yq \
 && apt clean


EXPOSE 9117
VOLUME [ "/config", "/downloads" ]


CMD [ "jackett" ]


HEALTHCHECK --start-period=10s --interval=30s --timeout=5s --retries=3 \
        CMD ["wget", "--tries", "5", "-qSO", "/dev/null",  "http://localhost:9117/"]
