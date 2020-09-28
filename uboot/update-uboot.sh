#!/bin/sh

set -e -x

# Installs u-boot to the Allwinner's approximation of MBR
dd if=/boot/u-boot-sunxi-with-spl.bin of=/dev/mmcblk0 bs=1024 seek=8
sync
