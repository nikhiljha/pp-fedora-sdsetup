#!/bin/bash
set -e

source .env

echo "This may fail! This is because it is set to download a file that is too old."
echo "Please visit https://dl.fedoraproject.org/pub/fedora-secondary/development/rawhide/Spins/aarch64/images/ and update the file name in .env with the new file name on that website."

echo "This script will download a few GB of Fedora and a few MB of Kernel into the current directory."
echo "Look inside the script if you would rather download manually."
echo
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Download kernel
    wget https://xff.cz/kernels/5.6/pp.tar.gz -O pp.tar.gz
    tar xf pp.tar.gz

    # Download fedora
    wget https://dl.fedoraproject.org/pub/fedora-secondary/development/rawhide/Spins/aarch64/images/$FEDORA_RAW_FILE -O rawhide.raw.xz
    xz --decompress rawhide.raw.xz
fi
