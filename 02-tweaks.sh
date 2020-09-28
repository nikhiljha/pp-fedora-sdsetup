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
infecho "ROOT_P3 = $ROOT_P3"
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
    infecho "Ensuring kernel updates won't break everything..."
    cat files/yum/fedora.repo > p3/etc/yum.repos.d/fedora.repo

    infecho "Writing your DNS servers to the image..."
    rm p3/etc/resolv.conf
    cp /etc/resolv.conf p3/etc/resolv.conf

    infecho "Tweaking gschemas..."
    mkdir -p p3/usr/share/glib-2.0/schemas/files/
    touch p3/usr/share/glib-2.0/schemas/files/90_pinephone.gschema.override
    cat files/90_pinephone.gschema.override > p3/usr/share/glib-2.0/schemas/files/90_pinephone.gschema.override
fi
