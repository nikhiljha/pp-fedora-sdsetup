#!/bin/bash
set -e

source .env

echo "================"
echo "04-edit-fstab.sh"
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
echo "=== WARNING WARNING WARNING ==="
echo
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    infecho "Mounting root file system..."
    mkdir -p rootfs
    mount $PP_PARTB rootfs

    infecho "Fixing /etc/fstab..."
    cat files/fstab > rootfs/etc/fstab

    infecho "Ensuring kernel updates won't break everything..."
    cat files/yum/fedora.repo > rootfs/etc/yum.repos.d/fedora.repo

    infecho "Tweaking gschemas..."
    mkdir -p rootfs/usr/share/glib-2.0/schemas/files/
    touch rootfs/usr/share/glib-2.0/schemas/files/90_pinephone.gschema.override
    cat files/90_pinephone.gschema.override > rootfs/usr/share/glib-2.0/schemas/files/90_pinephone.gschema.override

    infecho "Unmounting root file system..."
    sleep 3
    umount $PP_PARTB
    rmdir rootfs
fi
