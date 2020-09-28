#!/bin/bash
set -e

source .env

echo "=============="
echo "debug-mount.sh"
echo "=============="

losetup $ROOT_DEVICE rawhide.raw
partprobe -s /dev/loop0
mkdir -p p1
mkdir -p p2
mkdir -p p3
mount $ROOT_P1 p1
mount $ROOT_P2 p2
mount $ROOT_P3 p3
echo "Mounted rawhide.raw to ./p1 ./p2 ./p3."
