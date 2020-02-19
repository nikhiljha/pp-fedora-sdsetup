#!/bin/bash
set -e

source .env

echo "================"
echo "debug-unmount.sh"
echo "================"

umount $PP_PARTB
rmdir rootfs
