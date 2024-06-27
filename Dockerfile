FROM jlesage/baseimage-gui:alpine-3.20-v4

RUN add-pkg bash

COPY startapp.sh /startapp.sh

# Set the name of the application.
RUN set-cont-env APP_NAME "borg-viewer"
