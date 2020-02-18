set -e

cd pp-5.6
mkimage -A arm64 -T script -C none -d boot.cmd boot.scr
dd if=uboot.bin of=$PP_SD_DEVICE bs=1024 seek=8
mkdir -p bootfs
mkdir -p rootfs
mount $PP_PARTA bootfs
mount $PP_PARTB rootfs
cp boot.scr bootfs/
cp board.itb bootfs/
rsync -a --progress modules/lib/modules/* rootfs/lib/modules/
umount $PP_PARTA
umount $PP_PARTB
rmdir bootfs
rmdir rootfs
