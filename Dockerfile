FROM padhihomelab/debian-base:10.0_0.19.0_git.212b7514

ARG JACKETT_VERSION=0.17.213

ADD "https://github.com/Jackett/Jackett/releases/download/v${JACKETT_VERSION}/Jackett.Binaries.Mono.tar.gz" \
    /tmp/jackett.tar.gz

COPY jackett.sh      /usr/local/bin/jackett
COPY setup-volume.sh /etc/docker-entrypoint.d/setup-volume.sh

RUN chmod +x /etc/docker-entrypoint.d/setup-volume.sh \
             /usr/local/bin/jackett \
 && cd /tmp \
 && tar -xvzf jackett.tar.gz \
 && rm -rf Jackett/JackettUpdater* \
           /tmp/jackett.tar.gz \
 && mv /tmp/Jackett /jackett \
 && apt update \
 && apt install -yq apt-transport-https dirmngr gnupg ca-certificates \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
 && echo "deb https://download.mono-project.com/repo/debian stable-buster main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
 && apt update \
 && apt upgrade -yq \
 && apt install -yq ca-certificates-mono \
                    mono-devel \
                    wget \
 && apt autoremove -yq \
 && apt clean

EXPOSE 9117
VOLUME [ "/config", "/downloads" ]

CMD [ "jackett" ]

HEALTHCHECK --start-period=10s --interval=30s --timeout=5s --retries=3 \
        CMD ["wget", "--tries", "5", "-qSO", "/dev/null",  "http://localhost:9117/"]
