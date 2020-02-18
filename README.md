# sdsetup

A collection of scripts that correctly sets up Fedora to run off your PinePhone SD card.

## Dependencies

- wget
- xz
- f2f2-tools (for mkfs.f2fs)
- rsync
- uboot-tools (for mkimage)
- qemu-user-static (for qemu-aarch64-static)

## Usage

0. Use bash. `fish` and other weird shells are unsupported.
1. Edit `.env` with your own variables.
2. Ensure that all of your SD card partitions are unmounted, but visible in `lsblk`.
3. Run `bash 00-download-files.sh` then `sudo bash all.sh`, verify the information presented whenever it asks you to confirm.

## Tips

- Run all scripts other than 00-download-files.sh as root, and from this (README.md) directory! Do not directly run anything in the phone-scripts folder!
- If a script fails midway through, some things may still be mounted. `cleanup.sh` will attempt to unmount everything. Once again, run it as root!
