#!/usr/bin/env bash

USER=ruben
CACHE_DIR=/home/$USER/.cache
TRASH_DIR=/home/$USER/.local/share/Trash/expunged

# (0) Cache

echo "Cache size before cleaning:"
sudo du -sh $CACHE_DIR

cd $CACHE_DIR || exit
sudo rm -rf *

echo "Trash size before cleaning:"
sudo du -sh $TRASH_DIR

cd $TRASH_DIR || exit
sudo rm -rf *

# Optionally, you can print messages to confirm the cleanup
echo "Cache and Trash cleaned successfully."


# (1) Packages

echo "Get rid of packages that are no longer required:"
sudo apt-get autoremove


# (2) APT cache

echo "Clean up APT cache in Ubuntu:"
sudo du -sh /var/cache/apt
sudo apt-get autoclean
sudo apt-get clean


# (3) systemd journal logs

echo "Clear systemd journal logs:"
journalctl --disk-usage
sudo journalctl --vacuum-time=3d


# (4) Older versions of Snap applications

echo "Remove older versions of Snap applications:"

du -h /var/lib/snapd/snaps

set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done

echo "End."
