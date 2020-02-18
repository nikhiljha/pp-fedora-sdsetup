#!/bin/bash
set -e

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
PP_PARTB = ${PP_SD_DEVICE}2
read -p "Root Partition? [${PP_PARTB}] " -r
if [ ! -z "$REPLY" ]
then
    PP_PARTB=$REPLY
fi
read -p "Fedora extracted rootFS image? (.raw) [] " -r
# TODO: Autodetect the rootFS path if it's in the same directory.
# Perhaps by suggesting it if there's a file ending in .raw.
if [ ! -z "$REPLY" ]
then
    FEDORA_RAW=$REPLY
else
    errecho "You must tell me where your extracted Fedora raw image is downloaded."
fi

# Automatic Preflight Checks
if [[ $EUID -ne 0 ]]; then
    errecho "This script must be run as root!" 
    exit 1
fi

# TODO: Mount raw image.
# TODO: Mount pinephone FS.
# TODO: Detect and store third partition of raw image.

# Warning
echo "=== WARNING WARNING WARNING ==="
infecho "This script WILL COPY A TON OF FILES TO $PP_PARTB (mounted to $PP_ROOT_DIR)."
infecho "Also, I didn't test this so it might also cause WWIII or something."
infecho "I'm not responsible for anything that happens, you should read the script first."
echo "=== WARNING WARNING WARNING ==="
echo
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # rsync -ah --progress SOURCE DESTINATION
fi

infecho "If there are no errors above, the script was probably successful!"
