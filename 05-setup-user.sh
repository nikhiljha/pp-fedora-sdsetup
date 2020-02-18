set -e

mkdir -p rootfs
mount $PP_PARTB rootfs
cp /usr/bin/qemu-aarch64-static rootfs/usr/bin
cp phone-scripts/* rootfs/root
chroot /tmp/root qemu-aarch64-static /bin/bash all.sh
# TODO: Not sure if this type of command can work.
umount $PP_PARTB
rmdir rootfs
