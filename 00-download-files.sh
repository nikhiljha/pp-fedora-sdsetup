#!/bin/bash
set -e

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
    wget https://dl.fedoraproject.org/pub/fedora-secondary/development/rawhide/Workstation/aarch64/images/Fedora-Workstation-Rawhide-20200214.n.1.aarch64.raw.xz -o Fedora-Workstation-Rawhide-20200214.n.1.aarch64.raw.xz
    xz --decompress Fedora-Workstation-Rawhide-20200214.n.1.aarch64.raw.xz
fi
