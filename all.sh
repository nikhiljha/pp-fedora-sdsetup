echo "This script will NOT download the files."
echo "Do it yourself: sh 00-download-files.sh"
sh 00-selftest.sh
sh 01-partition-drive.sh
sh 02-install-rootfs.sh
sh 03-install-kernel.sh
sh 04-edit-fstab.sh
sh 05-setup-user.sh