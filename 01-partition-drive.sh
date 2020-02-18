#!/bin/bash
set -e

echo "====================="
echo "01-partition-drive.sh"
echo "====================="

# Functions
infecho () {
    echo "[Info] $1"
}
errecho () {
    echo $1 1>&2
}

# Notify User
infecho "The env vars that will be used in this script..."
infecho "PP_SD_DEVICE = $PP_SD_DEVICE"
PP_PARTA = ${PP_SD_DEVICE}1
PP_PARTB = ${PP_SD_DEVICE}2

# Automatic Preflight Checks
if [[ $EUID -ne 0 ]]; then
    errecho "This script must be run as root!" 
    exit 1
fi

# Warning
echo "=== WARNING WARNING WARNING ==="
infecho "This script WILL ERASE ALL DATA on $PP_SD_DEVICE."
infecho "Also, I didn't test this so it might also cause WWIII or something."
infecho "I'm not responsible for anything that happens, you should read the script first."
echo "=== WARNING WARNING WARNING ==="
echo
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    infecho "Begining drive partition..."
    sfdisk $PP_SD_DEVICE <<EOF
label: dos
unit: sectors

4MiB,252MiB,
256MiB,,
EOF
    infecho "Device partitioned!"

    infecho "Please use lsblk and tell me what the SMALLER partition is called..."
    read -p "Boot Partition? [${PP_PARTA}] " -r
    if [ ! -z "$REPLY" ]
    then
        PP_PARTA=$REPLY
    fi
    infecho "Please use lsblk and tell me what the LARGER partition is called..."
    read -p "Root Partition? [${PP_PARTB}] " -r
    if [ ! -z "$REPLY" ]
    then
        PP_PARTB=$REPLY
    fi

    infecho "Beginning filesystem creation..."
    infecho "If this fails, you might need to install mkfs.f2fs, which is usually called f2fs-tools."
    mkfs.vfat -n BOOT $PP_PARTA
    mkfs.f2fs -f -l ROOT $PP_PARTB
    infecho "Filesystems created!"
fi

infecho "If there are no errors above, the script was probably successful!"
