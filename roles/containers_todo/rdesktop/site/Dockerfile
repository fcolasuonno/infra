FROM lsiobase/rdesktop-web:alpine

# set version label
ARG BUILD_DATE
ARG VERSION
ARG FIREFOX_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
ENV SIDE_LOAD_DIR=/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/

RUN \
  echo "**** install packages ****" && \
  add-apt-repository -y ppa:mozillateam/ppa && \
  apt update && apt install -y \
    firefox-esr && \
  mkdir -p '/etc/firefox/' && \
  mkdir -p '/usr/lib/firefox-esr/distribution/' && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

COPY /policies.json /usr/lib/firefox-esr/distribution/
# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config