#!/bin/bash
# Backup the home directory using restic

# Restic exit status codes
# 0 when the backup was successful (snapshot with all source files created)
# 1 when there was a fatal error (no snapshot created)
# 3 when some source files could not be read (incomplete snapshot with remaining files created)

# Set restic environment variables
#export RESTIC_REPOSITORY="sftp:nas.local:/Backups/fedora-opc"
export RESTIC_REPOSITORY=
export export RESTIC_PASSWORD=

# Set local variables for restic script
BACKUP_DIR=
EXCLUDE_FILE=

# Send notification backup
# TODO(oscar): Add datetime
notify-send 'Backup' '16:00: backing up to NAS' --icon=dialog-information

# Execute restic backup
log=$(restic backup $BACKUP_DIR --verbose --exclude-file $EXCLUDE_FILE 2>&1)

# Ping healthcheck.sh to let it know backup is complete
# ENDPOINT: Report script's exit status (slug)
#           https://hc-ping.com/<ping-key>/<slug>/<exit-status>
PING_KEY=
SLUG=
RESTIC_OP_STATUS=$?
curl -fsS -m 10 --retry 5 --data-raw "$log" https://hc-ping.com/$PING_KEY/$SLUG/$RESTIC_OP_STATUS

