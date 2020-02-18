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
usermod -aG wheel pine
