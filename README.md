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
1. Edit `.env`, and run `source .env`.
2. Ensure that all of your SD card partitions are unmounted, but visible in `lsblk`.
3. Run `00-download-files.sh` then `all.sh`.
4. If there are prompts, answer them. If there are errors, you can restart from the step that it failed on after fixing the errors by running the script directly.
