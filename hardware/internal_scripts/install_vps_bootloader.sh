#!/bin/bash

source ../resources/config.sh

## install needed packages
apt install -y \
	grub-cloud-amd64 \
	grub-efi-amd64-signed \
	grub-efi-amd64-bin \
	cloud-guest-utils \
	cloud-init \
	linux-image-cloud-amd64

mv ../resources/fstab /etc/fstab

# install and configure grub
grub-install /dev/$HARDWARE_DISK_NAME
update-grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# make sure cloud-init will not change the hostname
sudo sed -i 's/preserve_hostname: false/preserve_hostname: true/' /etc/cloud/cloud.cfg