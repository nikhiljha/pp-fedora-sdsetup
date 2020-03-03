#!/bin/bash
set -e

source .env

echo "===================="
echo "03-install-kernel.sh"
echo "===================="

# Functions
infecho () {
    echo "[Info] $1"
}

# Notify User
infecho "The env vars that will be used in this script..."
infecho "PP_SD_DEVICE = $PP_SD_DEVICE"
infecho "PP_PARTA = $PP_PARTA"
infecho "PP_PARTB = $PP_PARTB"
echo

# Automatic Preflight Checks
if [[ $EUID -ne 0 ]]; then
    errecho "This script must be run as root!" 
    exit 1
fi

# Warning
echo "=== WARNING WARNING WARNING ==="
infecho "This script USES THE DD COMMAND AS ROOT. If the env vars are wrong, this could do something bad."
infecho "Make sure this script is run from the main dir of the repo, since it assumes that's true."
infecho "Also, I didn't test this so it might also cause WWIII or something."
infecho "I'm not responsible for anything that happens, you should read the script first."
echo "=== WARNING WARNING WARNING ==="
echo
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    infecho "Changing directory..."
    cd pp-5.6

    infecho "Generating boot.scr..."
    mkimage -A arm64 -T script -C none -d boot.cmd boot.scr

    infecho "Writing bootloader..."
    dd if=uboot.bin of=$PP_SD_DEVICE bs=1024 seek=8

    infecho "Changing directory back..."
    cd ../

    infecho "Mounting SD card partitions..."
    mkdir -p bootfs
    mkdir -p rootfs
    mount $PP_PARTA bootfs
    mount $PP_PARTB rootfs

    infecho "Copying boot.scr board.itb..."
    cp pp-5.6/boot.scr bootfs/
    cp pp-5.6/board.itb bootfs/

    infecho "Installing kernel modules..."
    rsync -a --progress pp-5.6/modules/lib/modules/* rootfs/lib/modules/

    infecho "Unmounting SD card partitions..."
    umount $PP_PARTA
    umount $PP_PARTB
    rmdir bootfs
    rmdir rootfs
fi
