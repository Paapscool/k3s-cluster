#!/bin/bash

# This script should be run from a debian server installation
# It will remove all data from the disk /dev/sdb (USB disk)
# and create the following partitions for a fresh debian installation:
# sdb
# ├─sdb1  EFI 256M
# ├─sdb2  SWAP Linux 2G
# └─sdb3  SYSTEM Linux 100%FREE (~12.4G)

# Then it will configure new password for your root session and install ssh

#
# Constants definition ---

EFI_PARTITION_NUMBER=1
SWAP_PARTITION_NUMBER=2
FS_PARTITION_NUMBER=3

EFI_PARTITION_SIZE="560M"
SWAP_PARTITION_SIZE="2G"
# FS_PARTITION_SIZE= # default, extend partition to end of disk

DEBIAN_VERSION="bookworm"
DEBIAN_REPOSITORY="http://ftp.debian.org/debian/"

DOMAIN_NAME=$1
DOMAIN_EXTENSION=$2
ROOT_PASSWORD=$3

#
## Script ---

./00_disk_partition.sh \
  $EFI_PARTITION_NUMBER \
  $SWAP_PARTITION_NUMBER \
  $FS_PARTITION_NUMBER \
  $EFI_PARTITION_SIZE \
  $SWAP_PARTITION_SIZE

# get the current swap partition number to close it later and replace it by the new one
SYSTEM_SWAP_PARTITION_NUMBER=$(sudo fdisk -l -o Device,Type | grep -w swap | grep sda | sed -e 's/\/dev\/sda//g' | sed -e 's/[[:space:]].*//g')

./01_debian_install.sh \
  $EFI_PARTITION_NUMBER \
  $SWAP_PARTITION_NUMBER \
  $FS_PARTITION_NUMBER \
  $DEBIAN_VERSION \
  $DEBIAN_REPOSITORY \
  $SYSTEM_SWAP_PARTITION_NUMBER

# retrieve partitions uuid
EFI_UUID_DISK=$(lsblk -o name,uuid | grep -w sdb$EFI_PARTITION_NUMBER | sed -e 's/.*sdb'$EFI_PARTITION_NUMBER' //g')
SWAP_UUID_DISK=$(lsblk -o name,uuid | grep -w sdb$SWAP_PARTITION_NUMBER | sed -e 's/.*sdb'$SWAP_PARTITION_NUMBER' //g')
FS_UUID_DISK=$(lsblk -o name,uuid | grep -w sdb$FS_PARTITION_NUMBER | sed -e 's/.*sdb'$FS_PARTITION_NUMBER' //g')

#
## Sub script ---
# script executed like chroot in the new system

echo "/tmp/sub_scripts/02_debian_configure.sh \
  $EFI_UUID_DISK \
  $SWAP_UUID_DISK \
  $FS_UUID_DISK \
  $DOMAIN_NAME \
  $DOMAIN_EXTENSION" | sudo chroot /mnt /bin/bash

echo "/tmp/sub_scripts/03_user_configure.sh \
  $ROOT_PASSWORD" | sudo chroot /mnt /bin/bash

## No security configuration

echo "/tmp/sub_scripts/05_enable_service.sh" | sudo chroot /mnt /bin/bash

# clean up
echo "rm -rf /tmp/sub_scripts" | sudo chroot /mnt /bin/bash

./06_cleanup_install.sh \
  $EFI_PARTITION_NUMBER \
  $SWAP_PARTITION_NUMBER \
  $FS_PARTITION_NUMBER \
  $SYSTEM_SWAP_PARTITION_NUMBER

# finish
echo "all is done, system should reboot now ..."

sudo systemctl reboot