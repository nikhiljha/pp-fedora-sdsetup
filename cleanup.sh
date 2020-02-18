#!/bin/bash

source .env

umount /dev/loop0p3
umount $PP_PARTB
umount $PP_PARTA
sleep 3
rmdir imgfs
rmdir rootfs
rmdir $KERNEL_RAW_DIR/imgfs
rmdir $KERNEL_RAW_DIR/rootfs
losetup -d /dev/loop0
