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

infecho "This adds my COPR repository (njha/mobile) and installs phone related packages."
infecho "Only functional on Fedora Rawhide."
infecho "HEAVY WIP, untested"

infecho "Enabling COPR repository..."
dnf copr enable njha/mobile

infecho "Installing recommended packages..."
dnf install feedbackd phoc phosh squeekboard gdm ModemManager gnome-terminal rtl8723cs-firmware \
    f2fs-tools chatty calls carbons purple-mm-sms pinephone-helpers evolution-data-server \
    f31-backgrounds-gnome kgx epiphany gnome-contacts evolution cheese NetworkManager-wwan

infecho "Enabling graphical boot and GDM..."
systemctl disable initial-setup.service
systemctl enable gdm
systemctl set-default graphical.target

infecho "Upgrading packages..."
dnf update --exclude="kernel kernel-core kernel-modules"
