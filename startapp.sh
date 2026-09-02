#!/bin/bash

mkdir -p /tmp/borg
# Let the unprivileged user that nautilus runs as traverse the mountpoint.
chmod 755 /tmp/borg

clean_up_backup() {
    set -x
    umount /tmp/borg
}

# Catch docker stop attempts
trap clean_up_backup SIGINT SIGTERM

# Remind the user that -o allow_other is required for nautilus to see the files.
cat >/etc/profile.d/borg-viewer-hint.sh <<'HINT'
cat <<'MSG'
Welcome to the Nextcloud AIO Borg Backup Viewer!

Mount your backup archives with (note the required -o allow_other):

    borg mount -o allow_other /mnt/borgbackup/borg /tmp/borg

Afterwards, open them in the file manager with:

    nautilus /tmp/borg

When you are done, unmount them again with:

    umount /tmp/borg

MSG
HINT

# Start xterm
exec xterm -ls
