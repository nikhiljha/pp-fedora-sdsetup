#!/bin/bash
set -e

source .env

echo "===================="
echo "02-install-rootfs.sh"
echo "===================="

# Functions
infecho () {
    echo "[Info] $1"
}
errecho () {
    echo "[Error] $1" 1>&2
    exit 1
}

# Ask for env vars...
infecho "The env vars that will be used in this script..."
infecho "PP_SD_DEVICE = $PP_SD_DEVICE"
infecho "PP_PARTA = $PP_PARTA"
infecho "PP_PARTB = $PP_PARTB"
infecho "FEDORA_RAW_FILE = $FEDORA_RAW_FILE"
echo

# Automatic Preflight Checks
if [[ $EUID -ne 0 ]]; then
    errecho "This script must be run as root!" 
    exit 1
fi

# Warning
echo "=== WARNING WARNING WARNING ==="
infecho "This script WILL COPY A TON OF FILES TO $PP_PARTB."
infecho "It will also try to mount to /dev/loop0. Make sure nothing else is there."
infecho "Also, I didn't test this so it might also cause WWIII or something."
infecho "I'm not responsible for anything that happens, you should read the script first."
echo "=== WARNING WARNING WARNING ==="
echo
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    infecho "Making mount directories..."
    mkdir -p imgfs
    mkdir -p rootfs

    infecho "Mounting Fedora image..."
    losetup /dev/loop0 rawhide.raw
    partprobe -s /dev/loop0
    mount /dev/loop0p3 imgfs

    infecho "Mounting SD Card rootfs..."
    partprobe -s $PP_SD_DEVICE
    # blockdev --rereadpt $PP_SD_DEVICE
    sleep 1 # Sometimes it lags.
    mount $PP_PARTB rootfs

    infecho "Copying files..."
    rsync -a --progress imgfs/* rootfs/

    infecho "Unmounting everything..."
    umount /dev/loop0p3
    losetup -d /dev/loop0
    umount $PP_PARTB

    infecho "Deleting temp directories..."
    rmdir imgfs
    rmdir rootfs
fi

infecho "If there are no errors above, the script was probably successful!"
