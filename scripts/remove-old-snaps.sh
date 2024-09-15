#!/usr/bin/env bash

# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS

# How to run it:
# $ sudo ./remove-old-snaps.sh

set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done

exit 0
