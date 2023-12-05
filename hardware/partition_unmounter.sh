#!/bin/bash

## args
ENUM_TARGET=$1

## enum
ENUM_TARGET_VPS=0
ENUM_TARGET_LOCAL=1

## create utils unmount script
echo "#!/bin/bash" > /utils_unmount.sh
echo "" >> /utils_unmount.sh
echo "sudo umount /mnt/run" >> /utils_unmount.sh
echo "sudo umount /mnt/sys" >> /utils_unmount.sh
echo "sudo umount /mnt/proc" >> /utils_unmount.sh
echo "sudo umount /mnt/dev/pts" >> /utils_unmount.sh
echo "sudo umount /mnt/dev" >> /utils_unmount.sh
echo "" >> /utils_unmount.sh
echo "sudo umount /mnt/data" >> /utils_unmount.sh
echo "sudo umount /mnt/boot/efi" >> /utils_unmount.sh
echo "sudo umount /mnt" >> /utils_unmount.sh

chmod +x /utils_unmount.sh

## read config and restore swap
if [ "$ENUM_TARGET" = "$ENUM_TARGET_LOCAL" ]; then
	source config_local.sh
	SYSTEM_SWAP_NUM_PART=$(sudo fdisk -l -o Device,Type | grep -w swap | grep $HARDWARE_RESCUE_DISK_NAME | sed -e 's/\/dev\/'"$HARDWARE_RESCUE_DISK_NAME"'//g' | sed -e 's/[[:space:]].*//g')
	sudo swapon /dev/$HARDWARE_RESCUE_DISK_NAME$SYSTEM_SWAP_NUM_PART
	sudo swapoff /dev/$HARDWARE_DISK_NAME$SWAP_NUM_PART
	# improve utils unmount script
	echo "" >> /utils_unmount.sh
	echo "sudo swapon /dev/$HARDWARE_RESCUE_DISK_NAME$SYSTEM_SWAP_NUM_PART" >> /utils_unmount.sh
	echo "sudo swapoff /dev/$HARDWARE_DISK_NAME$SWAP_NUM_PART" >> /utils_unmount.sh
else
	source config_vps.sh
fi

## unmount system
sudo umount /mnt/run
sudo umount /mnt/sys
sudo umount /mnt/proc
sudo umount /mnt/dev/pts
sudo umount /mnt/dev

## unmount partitions
sudo umount /mnt/data
sudo umount /mnt/boot/efi
sudo umount /mnt
