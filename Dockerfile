FROM debian:9.2

LABEL maintainer "opsxcq@strm.sh"

RUN apt-get update && \
    DEBIAN_FRONTEND=noniteractive apt-get install -y \
    apt-utils \
    dbus-x11 \
    dunst \
    hunspell-en-us \
    python3-dbus \
    software-properties-common \
    libx11-xcb1 \
    gconf2 \
    wget \
    curl \
    xz-utils \
    --no-install-recommends && \
    version=$(curl https://desktop.telegram.org/changelog | grep anchor | head -n 1 | cut -d '>' -f 7 | cut -d ' ' -f 2) && \
    echo "Installing telegram version ${version}" && \
    wget https://tdesktop.com/linux/tsetup.${version}.tar.xz -O /tmp/telegram.tar.xz && \
    cd /tmp/ && \
    tar xvfJ /tmp/telegram.tar.xz && \
    mv /tmp/Telegram/Telegram /usr/bin/Telegram && \
    rm -rf /tmp/{telegram.tar.xz,Telegram} && \
    rm /etc/fonts/conf.d/10-scale-bitmap-fonts.conf && \
    fc-cache -fv && \
    curl https://desktop.telegram.org/changelog | grep anchor | head -n 1 | cut -d '>' -f 7 | cut -d ' ' -f 2 > /version && \
    DEBIAN_FRONTEND=noniteractive apt-get purge -y \
    wget \
    curl \
    xz-utils &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb

CMD ["/usr/bin/Telegram"]
