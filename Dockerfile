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
        alpine-conf \
        nautilus \
        xterm \
        eog \
        gedit \
        vlc \
        font-terminus font-inconsolata font-dejavu font-noto font-noto-cjk font-awesome font-noto-extra font-liberation; \
    setup-desktop gnome; \
    rc-update add apk-polkit-server default
# TODO: add further dependencies like e.g. grsync onlyoffice-desktopeditors
# https://gitlab.alpinelinux.org/alpine/aports/-/issues/16847
# https://gitlab.alpinelinux.org/alpine/aports/-/issues/14535
