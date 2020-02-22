#!/bin/bash
set -e

source .env

echo "================"
echo "05-setup-user.sh"
echo "================"

# Functions
infecho () {
    echo "[Info] $1"
}

# Notify User
infecho "The env vars that will be used in this script..."
infecho "PP_PARTB = $PP_PARTB"
echo

# Automatic Preflight Checks
if [[ $EUID -ne 0 ]]; then
    errecho "This script must be run as root!" 
    exit 1
fi

# Warning
echo "=== WARNING WARNING WARNING ==="
infecho "I didn't test this so it might also cause WWIII or something."
infecho "I'm not responsible for anything that happens, you should read the script first."
infecho "This will also mount your /dev to the chroot. This is neccesary for DNF to"
infecho "function for the first time. This might do something weird to your host system."
echo "=== WARNING WARNING WARNING ==="
echo
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    infecho "Mounting rootfs..."
    mkdir -p rootfs
    mount $PP_PARTB rootfs

    infecho "Mounting /dev to the rootfs."
    mount --bind /dev rootfs/dev

    infecho "Installing qemu in rootfs..."
    cp /usr/bin/qemu-aarch64-static rootfs/usr/bin
    cp phone-scripts/* rootfs/root

    infecho "Chrooting with qemu into rootfs..."
    chroot rootfs qemu-aarch64-static /bin/bash /root/all.sh
    
    infecho "Unmounting rootfs..."
    sleep 3
    umount mnt-point/dev
    sleep 3
    umount $PP_PARTB
    rmdir rootfs
fi
