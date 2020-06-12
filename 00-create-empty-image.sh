#!/bin/bash
set -e

source .env

echo "========================"
echo "00-create-empty-image.sh"
echo "========================"

# Approximately 3GB image.
echo "Create image called $OUT_NAME? Make sure this doesn't exist, or it will be zeroed out."
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Creating blank 3GB file called $OUT_NAME."
    dd if=/dev/zero of=$OUT_NAME iflag=fullblock bs=1M count=3400 && sync
fi
