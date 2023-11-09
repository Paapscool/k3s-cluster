#!/bin/bash

# This script configure the debian system

EFI_UUID_DISK=$1
SWAP_UUID_DISK=$2
FS_UUID_DISK=$3

DOMAIN_NAME=$4
DOMAIN_EXTENSION=$5

# Update the system
apt update
apt upgrade -y

# Install dialog and apt-utils
apt install -y dialog apt-utils

# Install locales
apt install -y locales
sed -i 's/# C.UTF-8 UTF-8/C.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

# Update the bootloader
apt install -y linux-image-amd64 sudo network-manager
apt install -y grub-efi-amd64

# update the /etc/fstab file with the new UUID
# more information here: https://debian-facile.org/doc:systeme:fstab
echo "# /etc/fstab: static file system information." > /etc/fstab
echo "UUID=$SWAP_UUID_DISK none swap sw 0 0" >> /etc/fstab
echo "UUID=$FS_UUID_DISK / ext4 noatime,errors=remount-ro 0 1" >> /etc/fstab
echo "UUID=$EFI_UUID_DISK /boot/efi vfat noatime,umask=0077 0 1" >> /etc/fstab
echo "/dev/sr0 /media/cdrom0 udf,iso9660 user,noauto 0 0" >> /etc/fstab

grub-install --target=x86_64-efi --force-extra-removable /dev/sdb
update-initramfs -u
update-grub

# Install tools packages
apt install -y \
ethtool \
openssh-server \
openssl \
vim \
wget

# Configure MICROSOFT boot manager
mkdir -p /boot/efi/EFI/MICROSOFT/BOOT/
cp /boot/efi/EFI/BOOT/* /boot/efi/EFI/MICROSOFT/BOOT/
cp /boot/efi/EFI/BOOT/bootx64.efi /boot/efi/EFI/MICROSOFT/BOOT/bootmgfw.efi

# initramfs point to the swap partition
echo "RESUME=UUID=$SWAP_UUID_DISK" > /etc/initramfs-tools/conf.d/resume

## Update the default network configuration
# /etc/networks
echo "default		0.0.0.0" > /etc/networks
echo "loopback		127.0.0.0" >> /etc/networks
echo "link-local	169.254.0.0" >> /etc/networks
echo "" >> /etc/networks

# /etc/host.conf
echo "multi on" > /etc/host.conf

# /etc/hostname
echo "$DOMAIN_NAME$DOMAIN_EXTENSION" > /etc/hostname

# /etc/hosts
echo "127.0.0.1	localhost" > /etc/hosts
echo "127.0.1.1	$DOMAIN_NAME$DOMAIN_EXTENSION	$DOMAIN_NAME" >> /etc/hosts
echo "::1	localhost	ip6-localhost	ip6-loopback" >> /etc/hosts
echo "ff02::1	ip6-allnodes" >> /etc/hosts
echo "ff02::2	ip6-allrouters" >> /etc/hosts
echo "" >> /etc/hosts

printf "\n--------------------  Debian configured  --------------------\n\n"