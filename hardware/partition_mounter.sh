#!/bin/bash

## arguments
DISK_NAME=$1
EFI_NUM_PART=$2
FS_NUM_PART=$3
DATA_NUM_PART=$4

## mount partitions
mount /dev/$DISK_NAME$FS_NUM_PART /mnt
mkdir /mnt/{boot,home,srv,tmp,usr,var,data,dev,proc,sys,run}
mkdir /mnt/boot/{efi,grub}
mount /dev/$DISK_NAME$EFI_NUM_PART /mnt/boot/efi
mount /dev/$DISK_NAME$DATA_NUM_PART /mnt/data

chmod 1777 /mnt/tmp

# generate script to mount partitions
echo "#!/bin/bash" > /utils_mount.sh
echo "" >> /utils_mount.sh
echo "mount /dev/$DISK_NAME$FS_NUM_PART /mnt" >> /utils_mount.sh
echo "mount /dev/$DISK_NAME$EFI_NUM_PART /mnt/boot/efi" >> /utils_mount.sh
echo "mount /dev/$DISK_NAME$DATA_NUM_PART /mnt/data" >> /utils_mount.sh
chmod +x /utils_mount.sh

