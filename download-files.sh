#!/bin/bash
set -e

source .env

echo "This script will download a few GB of Fedora and a few MB of Kernel into the current directory."
echo "Look inside the script if you would rather download manually."
echo
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Download kernel
    wget https://xff.cz/kernels/5.7/pp1.tar.gz -O pp.tar.gz
    tar xf pp.tar.gz

    # Get latest rawhide from repo when not set in .env
    if [ -z "$FEDORA_RAW_FILE" ]
    then
        echo "Searching for latest Fedora Rawhide..."
        FEDORA_RAW_VER=$(wget -q $FEDORA_RAW_SOURCE -O - | grep -Po '(?<=Fedora-Minimal-Rawhide-).*?(?=.aarch64)' | head -n 1)
        if [ ! -z "$FEDORA_RAW_VER" ]
        then
            echo "Downloading latest Fedora version: $FEDORA_RAW_VER"
            FEDORA_RAW_FILE=Fedora-Minimal-Rawhide-$FEDORA_RAW_VER.aarch64.raw.xz
            echo ""
        else
            echo "Could not obtain latest version data"
            echo "Please visit $FEDORA_RAW_SOURCE uncomment and update the FEDORA_RAW_FILE name in .env with the name on that website."
            exit 1
        fi
    else
        echo "Downloading Fedora set in .env file: $FEDORA_RAW_FILE"
        echo "This may fail if it is set to download a file that is too old."
        echo ""
    fi

    # Download fedora
    wget $FEDORA_RAW_SOURCE/$FEDORA_RAW_FILE -O rawhide.raw.xz
    xz --decompress rawhide.raw.xz
fi
