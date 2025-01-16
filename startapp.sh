#!/bin/bash

mkdir -p /tmp/borg

clean_up_backup() {
    set -x
    umount /tmp/borg
}

# Catch docker stop attempts
trap clean_up_backup SIGINT SIGTERM

# Start xterm
xhost +si:localuser:root
exec xterm
