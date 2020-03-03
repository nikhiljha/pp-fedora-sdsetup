#!/bin/bash
set -e

echo "==================="
echo "02-install-packages.sh"
echo "==================="

# Functions
infecho () {
    echo "[Info] $1"
}
errecho () {
    echo "[Error] $1" 1>&2
    exit 1
}

infecho "This DELETES the gnome-shell desktop file so that gdm boots"
infecho "to phosh instead. This means you're wasting space keeping gnome-shell"
infecho "on your sdcard. It's inefficient but it'll do for now."

infecho "Deleting all xorg based sessions..."
rm -fr /usr/share/xsessions/*

infecho "Deleting gnome for wayland..."
rm /usr/share/wayland-sessions/gnome.desktop

infecho "Installing autologin (ASSUMING DEFAULT SCRIPT USERNAME = PINE)..."
cat /root/gdm-custom.conf > /etc/gdm/custom.conf
