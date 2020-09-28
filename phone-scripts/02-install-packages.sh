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
infecho "Likely only functional on Fedora Rawhide, but it might work on F33/F32 as well (untested)."

infecho "Enabling COPR repository..."
dnf copr enable njha/mobile

infecho "Enabling kernel repository..."
infecho "For more information on this repository, see https://ocf.berkeley.edu/~njha/pinephone/"
CUSTOMREPO="/etc/yum.repos.d/njha-ocf.repo"
cat > $CUSTOMREPO <<EOF
[njha-ocf]
name=njha's pinephone repository at OCF
baseurl=https://ocf.berkeley.edu/~njha/pinephone/repo
enabled=1
priority=10
gpgcheck=0
EOF

infecho "Removing old kernel..."
infecho "THIS WILL FAIL, DON'T WORRY ITS PROBABLY OK"
dnf remove kernel || rpm -e --noscripts kernel-core
dnf install linux-firmware

infecho "Installing kernel..."
dnf --disablerepo="*" --enablerepo="njha-ocf" install kernel

infecho "Installing recommended packages..."
dnf install feedbackd phoc phosh squeekboard gnome-shell ModemManager rtl8723cs-firmware \
    f2fs-tools chatty calls carbons purple-mm-sms pinephone-helpers evolution-data-server \
    f32-backgrounds-gnome kgx epiphany gnome-contacts evolution cheese NetworkManager-wwan \
    lightdm-mobile-greeter

infecho "Enabling graphical boot and lightdm..."
systemctl disable initial-setup.service
systemctl enable lightdm
systemctl set-default graphical.target

infecho "Upgrading packages..."
dnf update
