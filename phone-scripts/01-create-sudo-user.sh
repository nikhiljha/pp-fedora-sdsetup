#!/bin/bash
set -e

echo "======================"
echo "01-create-sudo-user.sh"
echo "======================"

# Functions
infecho () {
    echo "[Info] $1"
}

infecho "Adding user \"pine\"..."
adduser pine
passwd pine

# video is the old group for feedbackd
usermod -aG wheel,video pine

