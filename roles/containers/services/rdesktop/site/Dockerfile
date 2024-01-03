#
# rdesktop Dockerfile
#
FROM lscr.io/linuxserver/firefox:latest

# Define software versions.
ARG TMM_VERSION=3.1.18
ARG MEGATOOL_VERSION_URL=https://megatools.megous.com/builds/LATEST

# Define software download URLs.
ARG TMM_URL=https://release.tinymediamanager.org/v3/dist/tmm_${TMM_VERSION}_linux.tar.gz
ARG MEGATOOL_URL=https://megatools.megous.com/builds/builds/
# Define working directory.
WORKDIR /tmp

# Download Megatool
RUN \
    MEGATOOL_VERSION="$(curl -k -s $MEGATOOL_VERSION_URL)" && \
    wget --no-check-certificate ${MEGATOOL_URL}${MEGATOOL_VERSION}-linux-x86_64.tar.gz -O - | tar -xz && \
    cp mega*/megatools /usr/bin

# Download TinyMediaManager
RUN \
    mkdir -p /defaults && \
    wget ${TMM_URL} -O /defaults/tmm.tar.gz

# Download and install Oracle JRE.
# NOTE: This is needed only for the 7-Zip-JBinding workaround.

# Install packages
RUN \
    apk add \
        openjdk17-jre \
        libmediainfo \
        ttf-dejavu \
        bash \
        lxterminal \
        transmission \
        xrdp \
        thunar \
        adwaita-icon-theme \
        openresolv \
        wireguard-tools \
        python3 py3-requests

RUN \
  echo "wireguard" >> /etc/modules && \
  ln -s /usr/sbin/resolvconf /usr/bin/resolvconf

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
