FROM padhihomelab/alpine-base:3.19.1_0.19.0_0.2 as base
ARG TARGETARCH

FROM base AS base-amd64
ENV JACKETT_ARCH=AMDx64

FROM base AS base-arm64
ENV JACKETT_ARCH=ARM64

FROM base AS base-armv7
ENV JACKETT_ARCH=ARM32

FROM base-${TARGETARCH}${TARGETVARIANT}


ARG JACKETT_VERSION=0.21.2042


ADD "https://github.com/Jackett/Jackett/releases/download/v${JACKETT_VERSION}/Jackett.Binaries.LinuxMusl${JACKETT_ARCH}.tar.gz" \
    /tmp/jackett.tar.gz


COPY jackett.sh \
     /usr/local/bin/jackett
COPY entrypoint-scripts \
     /etc/docker-entrypoint.d/99-extra-scripts


RUN chmod +x /etc/docker-entrypoint.d/99-extra-scripts/*.sh \
             /usr/local/bin/jackett \
 && apk add --no-cache --update \
            icu-libs \
            tzdata \
 && cd /tmp \
 && tar -xvzf jackett.tar.gz \
 && rm -rf Jackett/JackettUpdater* \
           /tmp/jackett.tar.gz \
 && mv /tmp/Jackett /jackett


EXPOSE 9117
VOLUME [ "/config", "/downloads" ]


CMD [ "jackett" ]


HEALTHCHECK --start-period=10s --interval=30s --timeout=5s \
        CMD ["wget", "--tries", "5", "-qSO", "/dev/null",  "http://127.0.0.1:9117/UI/Login"]
