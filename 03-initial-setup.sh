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
infecho "ROOT_P3 = $ROOT_P3"
infecho "ROOT_P2 = $ROOT_P2"
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
echo "=== WARNING WARNING WARNING ==="
echo
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    infecho "Installing qemu in rootfs..."
    cp /usr/bin/qemu-aarch64-static p3/usr/bin
    cp phone-scripts/* p3/root

    infecho "Mounting bootfs into rootfs..."
    umount p2
    mount $ROOT_P2 p3/boot

    infecho "Mounting your /dev into the rootfs..."
    infecho "This is neccesary for dnf to work, because reasons."
    mount --bind /dev p3/dev

    infecho "Chrooting with qemu into rootfs..."
    chroot p3 qemu-aarch64-static /bin/bash /root/all.sh

    infecho "KILLING ALL QEMU PROCESSES, MAKE SURE YOU HAVE NO MORE RUNNING!"
    killall -9 /usr/bin/qemu-aarch64-static
    
    infecho "Unmounting your /dev from the rootfs..."
    sleep 3
    umount p3/dev

    infecho "Unmounting /boot from /root..."
    umount p3/boot
    mount $ROOT_P2 p2
fi
