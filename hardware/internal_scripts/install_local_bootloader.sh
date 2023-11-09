#!/bin/bash

source ../resources/config.sh

## install needed packages
apt install -y \
	linux-image-amd64 \
	grub-efi-amd64 \
	network-manager

mv ../resources/fstab /etc/fstab

# install and configure grub
grub-install --target=x86_64-efi --removable /dev/$HARDWARE_DISK_NAME
update-initramfs -u
update-grub

# setup swap uuid disk usage
mv ../resources/resume /etc/initramfs-tools/conf.d/resume