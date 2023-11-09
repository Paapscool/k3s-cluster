#!/bin/bash

# This script mount partitions and install fresh debian on the disk /dev/sdb
# Also, copy resources files to the new system (in /tmp)

EFI_PARTITION_NUMBER=$1
SWAP_PARTITION_NUMBER=$2
FS_PARTITION_NUMBER=$3

DEBIAN_VERSION=$4
DEBIAN_REPOSITORY=$5

SYSTEM_SWAP_PARTITION=/dev/sda$6

# create mount points
if [ ! -d "/mnt" ]; then
  sudo mkdir /mnt
fi

# mount partitions
sudo mount /dev/sdb$FS_PARTITION_NUMBER /mnt
sudo mkdir -p /mnt/boot/efi
sudo mount /dev/sdb$EFI_PARTITION_NUMBER /mnt/boot/efi

# update tmp rights
sudo mkdir /mnt/tmp
sudo chmod 1777 /mnt/tmp

# Change swap partition
sudo swapon /dev/sdb$SWAP_PARTITION_NUMBER
sudo swapoff $SYSTEM_SWAP_PARTITION

# download and install debian
sudo apt install -y dialog apt-utils
sudo apt install -y debootstrap
sudo debootstrap --arch amd64 bookworm /mnt http://ftp.debian.org/debian/

# mount partitions system to execute command in the fresh installation
sudo mount -v --bind /dev /mnt/dev
sudo mount -vt devpts /dev/pts /mnt/dev/pts
sudo mount -vt proc /proc /mnt/proc
sudo mount -vt sysfs /sys /mnt/sys
sudo mount -vt tmpfs /run /mnt/run

sudo cp -r ./sub_scripts /mnt/tmp/sub_scripts

printf "\n--------------------  debian install  --------------------\n"
echo "debian $DEBIAN_VERSION installed on /dev/sdb$FS_PARTITION_NUMBER"
echo "partitions system mounted on /mnt"
printf "\n\n"
