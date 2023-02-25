#
# rdesktop Dockerfile
#
FROM lscr.io/linuxserver/firefox:latest

# Define software versions.
ARG JAVAJRE_VERSION=8.302.08.1
ARG TMM_VERSION=3.1.18

# Define software download URLs.
ARG TMM_URL=https://release.tinymediamanager.org/v3/dist/tmm_${TMM_VERSION}_linux.tar.gz
ARG MEGATOOL_URL=https://megatools.megous.com/builds/builds/megatools-1.11.0.20220519-linux-x86_64.tar.gz
# Define working directory.
WORKDIR /tmp

# Download Megatool
RUN \
    wget ${MEGATOOL_URL} -O - | tar -xz && \
    cp mega*/megatools /usr/bin

# Download TinyMediaManager
RUN \
    mkdir -p /defaults && \
    wget ${TMM_URL} -O /defaults/tmm.tar.gz

# Download and install Oracle JRE.
# NOTE: This is needed only for the 7-Zip-JBinding workaround.

# Install dependencies
RUN \
    apk add \
        openjdk17-jre \
        libmediainfo \
        ttf-dejavu \
        bash \
        sakura \
        transmission \
        xrdp \
        thunar \
        adwaita-icon-theme

RUN \
  echo "**** install dependencies ****" && \
  apk add --no-cache --virtual=build-dependencies \
    bc \
    build-base \
    coredns \
    elfutils-dev \
    gcc \
    git \
    linux-headers && \
  apk add --no-cache \
    bc \
    coredns \
    gnupg \
    iproute2 \
    iptables \
    ip6tables \
    iputils \
    libqrencode \
    net-tools \
    openresolv \
    python3 py3-requests \
    perl && \
  echo "wireguard" >> /etc/modules && \
  echo "**** install wireguard-tools ****" && \
  if [ -z ${WIREGUARD_RELEASE+x} ]; then \
    WIREGUARD_RELEASE=$(curl -sX GET "https://api.github.com/repos/WireGuard/wireguard-tools/tags" \
    | jq -r .[0].name); \
  fi && \
  cd /app && \
  git clone https://git.zx2c4.com/wireguard-linux-compat && \
  git clone https://git.zx2c4.com/wireguard-tools && \
  cd wireguard-tools && \
  git checkout "${WIREGUARD_RELEASE}" && \
  make -C src -j$(nproc) && \
  make -C src install && \
  sed -i '/\[\[ $proto == -4 \]\] && cmd sysctl -q net\.ipv4\.conf\.all\.src_valid_mark=1/d' /usr/bin/wg-quick && \
  echo "**** clean up ****" && \
  apk del --no-network build-dependencies && \
  rm -rf \
    /tmp/*

# Add files
COPY root/ /

# Define mountable directories.
VOLUME /config
VOLUME /media
VOLUME /downloads

ENV PS1 "\u@\h:\w\$"

# Metadata.
LABEL \
      org.label-schema.name="rdesktop" \
      org.label-schema.description="Docker container for rdesktop" \
      org.label-schema.schema-version="1.0"
