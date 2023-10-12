FROM ghcr.io/linuxserver/webtop:ubuntu-openbox
RUN \
    apt update && \
    apt install -y libwebkit2gtk-4.0-37 inkscape \
      wget nano xdg-utils tar xzip gzip bzip2 zip unzip \
      gstreamer1.0-plugins-bad gstreamer1.0-libav bash-completion \
      lxterminal python3-urllib3 python3-requests python3-gi gobject-introspection gir1.2-gtk-3.0 \
      imagemagick lxterminal font-manager

RUN mkdir -p /configs

COPY menu.xml /etc/xdg/openbox/

VOLUME /configs/

COPY /root /