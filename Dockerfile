FROM jlesage/baseimage-gui:alpine-3.20-v4

COPY startapp.sh /startapp.sh

# Set the name of the application.
RUN set-cont-env APP_NAME "borg-viewer"

# hadolint ignore=DL3002
USER root

ENV USER_ID=0 \
    GROUP_ID=0 \
    WEB_AUDIO=1 \
    WEB_AUTHENTICATION=1 \
    SECURE_CONNECTION=1 \
    HOME=/root

# hadolint ignore=DL3018
RUN set -ex; \
    \
    apk upgrade --no-cache -a; \
    apk add --no-cache \
        util-linux-misc \
        bash \
        borgbackup \
        rsync \
        fuse \
        py3-llfuse \
        jq \
        nautilus \
        xterm \
        eog \
        gedit \
        vlc
# TODO: add further dependencies like e.g. grsync onlyoffice-desktopeditors
