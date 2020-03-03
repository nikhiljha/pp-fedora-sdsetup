#!/bin/bash
set -e

bash /root/01-create-sudo-user.sh
bash /root/02-install-packages.sh
bash /root/03-enable-autoboot.sh
