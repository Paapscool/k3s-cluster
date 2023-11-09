#!/bin/bash

EFI_PARTITION_NUMBER=$1
SWAP_PARTITION_NUMBER=$2
FS_PARTITION_NUMBER=$3

SYSTEM_SWAP_PARTITION=/dev/sda$4

# reset swap partition
sudo swapon $SYSTEM_SWAP_PARTITION
sudo swapoff /dev/sdb$SWAP_PARTITION_NUMBER

sudo umount /mnt/run
sudo umount /mnt/sys
sudo umount /mnt/proc
sudo umount /mnt/dev/pts
sudo umount /mnt/dev

sudo umount /mnt/boot/efi
sudo umount /mnt

cd /tmp
sudo rm -rf /tmp/install

# Configure reboot on USB rescue key
RESCUEKEY_NB=$(sudo efibootmgr | grep -w 'USB DISK' | sed -e 's/Boot//g' | sed -e 's/\*.*USB DISK.*//g')
sudo efibootmgr --bootnext $RESCUEKEY_NB

printf "\n--------------------  Cleanup installation  --------------------\n\n"