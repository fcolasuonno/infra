FROM ghcr.io/linuxserver/webtop:ubuntu-openbox
RUN \
    apt update && \
    apt install -y libwebkit2gtk-4.0-37 inkscape \
      wget nano xdg-utils tar xzip gzip bzip2 zip unzip \
      gstreamer1.0-plugins-bad gstreamer1.0-libav

WORKDIR /orcaslicer
ADD get_release_info.sh /orcaslicer

RUN mkdir -p /orcaslicer/orcaslicer-dist
RUN chmod +x /orcaslicer/get_release_info.sh

# Retrieve and unzip all of the OrcaSlicer bits using variable.
RUN latestOrcaslicer=$(/orcaslicer/get_release_info.sh url) \
&& echo ${latestOrcaslicer} \
&& orcaslicerReleaseName=$(/orcaslicer/get_release_info.sh name) \
&& curl -sSL ${latestOrcaslicer} > ${orcaslicerReleaseName} \
&& rm -f /orcaslicer/releaseInfo.json \
&& mkdir -p /orcaslicer/orcaslicer-dist \
&& unzip ${orcaslicerReleaseName} -d /orcaslicer/orcaslicer-dist \
&& chmod 775 /orcaslicer/orcaslicer-dist/OrcaSlicer_ubu64.AppImage \
&& /orcaslicer/orcaslicer-dist/OrcaSlicer_ubu64.AppImage --appimage-extract \
&& rm -f /orcaslicer/${orcaslicerReleaseName}

RUN chmod -R 777 /orcaslicer/
RUN mkdir -p /orcaslicer
RUN mkdir -p /configs

COPY menu.xml /etc/xdg/openbox/

VOLUME /configs/

COPY /root /