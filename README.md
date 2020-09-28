# <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Fedora_logo.svg/200px-Fedora_logo.svg.png" width="25" height="25"> PinePhone Fedora Remix

A collection of scripts that sets up Fedora to run on your PinePhone. Soon to be a part of upstream Fedora (targeting F34).

## **🚨🚨🚨 SERIOUS WARNING- READ ME! 🚨🚨🚨** 
This is a **barely tested** collection of scripts written by someone who has never written a bash script for other people to use! It involves the **dd** command and **sudo**. This is **VERY DANGEROUS** - please do not run it unless you have read and fully understood what it will do. Better yet, read the scripts to learn how to install the image manually.

You should also understand [the risks involved](https://xnux.eu/log/#017) with using a PinePhone vs a mass produced phone. **Many of the safety checks we take for granted (battery voltage/temperature regulation) are nonexistent on the PinePhone.** "It could blow up" (although this has not happened before, to my knowledge) is a very real possibility!

## Dependencies

- wget
- xz
- f2fs-tools (for mkfs.f2fs)
- dosfstools (for mkfs.vfat)
- rsync
- u-boot-tools (for mkimage)
- qemu-user-static (for qemu-aarch64-static)

## Usage

Usage information is out of date. I would now (Sep 2020) recommend reading the scripts to get a general idea of what you need to do, and then start with a stock Fedora installation and customize the image yourself.

1. Edit `.env` with your own variables.
2. Run `bash download-files.sh` then `sudo bash all.sh`. Verify the information presented whenever it asks you to confirm.

## Tips

- Run all scripts other than download-files.sh as root, and from this (README.md) directory! Do not directly run anything in the phone-scripts folder! Those scripts are, as the name suggests, executed on the phone.
- If a script fails midway through, some things may still be mounted. `sudo ./cleanup.sh` will attempt to unmount everything.
