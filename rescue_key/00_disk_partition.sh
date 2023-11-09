#!/bin/bash

## Rescue live USB creation script

# to create the partitions programatically (rather than manually)
# we're going to simulate the manual input to fdisk
# Relavant information here: https://ivanb.neocities.org/blogs/y2022/debootstrap

# Inputs definition

EFI_PARTITION_NUMBER=${1}
SWAP_PARTITION_NUMBER=${2}
FS_PARTITION_NUMBER=${3}

EFI_PARTITION_SIZE=${4}
SWAP_PARTITION_SIZE=${5}
# FS_PARTITION_SIZE= # default, extend partition to end of disk

EFI_PARTITION_TYPE=1
SWAP_PARTITION_TYPE=19
# FS_PARTITION_TYPE= # default, Linux filesystem

# Remove all partition from your usb key
sudo umount /dev/sdb
sudo dd if=/dev/zero of=/dev/sdb bs=512 count=1 conv=notrunc

# create the new partitions
(
# create a new empty GPT partition table
echo g

# create efi partition
echo n
echo $EFI_PARTITION_NUMBER
# default, start immediately after preceding partition
echo
echo +$EFI_PARTITION_SIZE
# change partition type with default selection of partition number
echo t
echo $EFI_PARTITION_TYPE

# create swap partition
echo n
echo $SWAP_PARTITION_NUMBER
# default - start at beginning of free space
echo
echo +$SWAP_PARTITION_SIZE
echo t
echo $SWAP_PARTITION_NUMBER
echo $SWAP_PARTITION_TYPE

# create file system partition
echo n
echo $FS_PARTITION_NUMBER
# default, start immediately after preceding partition
echo
# default, extend partition to end of disk
echo

# write changes
echo w
) | sudo fdisk /dev/sdb

# format partitions
sudo apt install -y e2fsprogs dosfstools

yes n | sudo mkfs.vfat -F 32 -n 'USBBOOT' /dev/sdb$EFI_PARTITION_NUMBER
yes n | sudo mkswap -L 'USBSWAP' /dev/sdb$SWAP_PARTITION_NUMBER
yes n | sudo mkfs.ext4 -L 'USBROOT' /dev/sdb$FS_PARTITION_NUMBER

printf "\n--------------------  Partitioning done  --------------------\n\n"