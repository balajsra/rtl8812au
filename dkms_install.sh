#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Copy source files
apt install build-essential dkms
mkdir -p /usr/src/8812au-4.2.2
cp -r * /usr/src/8812au-4.2.2

# Add driver to DKMS
dkms add -m 8812au -v 4.2.2
dkms build -m 8812au -v 4.2.2
dkms install -m 8812au -v 4.2.2

# Check status
sudo dkms status

# Automatically load at boot
echo 8812au | sudo tee -a /etc/modules
