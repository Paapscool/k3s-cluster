#!/bin/bash

RESOURCE_PATH=$1

source $RESOURCE_PATH/config.sh

## install needed packages
apt install -y \
	linux-image-amd64 \
	grub-efi-amd64 \
	network-manager

mv $RESOURCE_PATH/fstab /etc/fstab

# install and configure grub
grub-install --target=x86_64-efi --removable /dev/$HARDWARE_DISK_NAME
update-initramfs -u
update-grub

# setup swap uuid disk usage
mv $RESOURCE_PATH/resume /etc/initramfs-tools/conf.d/resume