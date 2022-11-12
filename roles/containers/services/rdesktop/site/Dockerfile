#
# rdesktop Dockerfile
#
FROM lscr.io/linuxserver/firefox:latest

# Define software versions.
ARG JAVAJRE_VERSION=8.302.08.1
ARG TMM_VERSION=3.1.17

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
        transmission

# Add files
COPY root/ /

# Define mountable directories.
VOLUME /config
VOLUME /media
VOLUME /downloads

# Metadata.
LABEL \
      org.label-schema.name="rdesktop" \
      org.label-schema.description="Docker container for rdesktop" \
      org.label-schema.schema-version="1.0"
