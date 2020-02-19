#!/bin/bash
set -e

source .env

echo "=============="
echo "debug-mount.sh"
echo "=============="

mkdir -p rootfs
partprobe -s $PP_SD_DEVICE
blockdev --rereadpt $PP_SD_DEVICE
sleep 1 # Sometimes it lags.
mount $PP_PARTB rootfs
