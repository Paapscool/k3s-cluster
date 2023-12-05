#!/bin/bash

RESOURCE_PATH=$1

source $RESOURCE_PATH/config.sh

## install needed packages
apt install -y \
	grub-cloud-amd64 \
	grub-efi-amd64-signed \
	grub-efi-amd64-bin \
	cloud-guest-utils \
	cloud-init \
	linux-image-cloud-amd64

mv $RESOURCE_PATH/fstab /etc/fstab

# install and configure grub
grub-install /dev/$HARDWARE_DISK_NAME
update-grub
grub-mkconfig -o /boot/grub/grub.cfg

# make sure cloud-init will not change the hostname
sed -i 's/preserve_hostname: false/preserve_hostname: true/' /etc/cloud/cloud.cfg