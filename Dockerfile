FROM jlesage/baseimage-gui:alpine-3.24-v4.13.2

COPY --chmod=775 startapp.sh /startapp.sh
# Nautilus refuses to start as root, so this wrapper starts it unprivileged.
COPY --chmod=775 nautilus /opt/bin/nautilus

# Set the name of the application.
RUN set-cont-env APP_NAME "Nextcloud AIO Borg Backup Viewer"

ENV USER_ID=0 \
    GROUP_ID=0 \
    WEB_AUDIO=1 \
    WEB_AUTHENTICATION=1 \
    SECURE_CONNECTION=1 \
    HOME=/root \
    PATH=/opt/bin:$PATH

RUN set -ex; \
    \
    add-pkg \
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
    rc-update add apk-polkit-server default; \
    \
    # The user nautilus runs as. Declared here because the baseimage rewrites
    # /etc/passwd on startup. See https://github.com/szaimen/aio-borgbackup-viewer/issues/42
    mkdir -p /etc/cont-users.d/viewer /etc/cont-groups.d/viewer; \
    echo 1000 > /etc/cont-users.d/viewer/id; \
    echo 1000 > /etc/cont-users.d/viewer/gid; \
    echo /home/viewer > /etc/cont-users.d/viewer/home; \
    echo 1000 > /etc/cont-groups.d/viewer/id; \
    # Nautilus needs a writable home for its dconf and fontconfig caches.
    mkdir -p /home/viewer; \
    chown 1000:1000 /home/viewer; \
    \
    # Let that user read archives that root mounted with `-o allow_other`.
    sed -i 's/^#user_allow_other$/user_allow_other/' /etc/fuse.conf; \
    grep -q '^user_allow_other$' /etc/fuse.conf
# TODO: add further dependencies like e.g. grsync onlyoffice-desktopeditors
# https://gitlab.alpinelinux.org/alpine/aports/-/issues/16847
# https://gitlab.alpinelinux.org/alpine/aports/-/issues/14535


# Needed for Nextcloud AIO so that image cleanup can work. 
# Unfortunately, this needs to be set in the Dockerfile in order to work.
LABEL org.label-schema.vendor="Nextcloud"
