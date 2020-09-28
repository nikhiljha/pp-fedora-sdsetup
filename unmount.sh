#!/bin/bash
set -e

source .env

echo "================"
echo "debug-unmount.sh"
echo "================"

losetup -d /dev/loop0
umount $ROOT_P1
umount $ROOT_P2
umount $ROOT_P3
rmdir p1
rmdir p2
rmdir p3
