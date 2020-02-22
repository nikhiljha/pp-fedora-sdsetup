#!/bin/bash
set -e

echo "=================="
echo "02-enable-gnome.sh"
echo "=================="

dnf group install “GNOME Desktop Environment”
systemctl set-default graphical.target
