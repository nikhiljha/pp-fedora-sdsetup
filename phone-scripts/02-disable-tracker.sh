#!/bin/bash
set -e

echo "====================="
echo "02-disable-tracker.sh"
echo "====================="

echo "This disables GNOME Tracker."
systemctl mask tracker-store.service tracker-miner-fs.service tracker-miner-rss.service tracker-extract.service tracker-miner-apps.service tracker-writeback.service
