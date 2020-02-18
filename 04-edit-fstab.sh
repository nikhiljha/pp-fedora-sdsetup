set -e

mkdir -p rootfs
mount $PP_PARTB rootfs
# TODO: Edit the /etc/fstab with the proper entries.
umount $PP_PARTB
rmdir rootfs
