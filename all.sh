#!/bin/bash
set -e

echo "This script will NOT download the files."
echo "Do it yourself: sh 00-download-files.sh"
bash 00-selftest.sh
bash 01-partition-drive.sh
bash 02-install-rootfs.sh
bash 03-install-kernel.sh
bash 04-edit-fstab.sh
bash 05-setup-user.sh