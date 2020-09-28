#!/bin/bash
set -e

echo "This script will NOT download the files."
echo "Do it yourself: sh 00-download-files.sh"
bash 00-selftest.sh
bash mount.sh
bash 01-install-uboot.sh
bash 02-tweaks.sh
bash 03-initial-setup.sh
bash unmount.sh
