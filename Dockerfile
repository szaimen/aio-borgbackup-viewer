FROM jlesage/baseimage-gui:alpine-3.20-v4

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
        jq

COPY startapp.sh /startapp.sh

# Set the name of the application.
RUN set-cont-env APP_NAME "borg-viewer"
