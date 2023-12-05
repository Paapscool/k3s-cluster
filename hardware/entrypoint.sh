#!/bin/bash

## args
USER_PASSWORD=$1
USER_SSH_KEY=$2

## Constants
TARGET_VPS="vps"
TARGET_LOCAL="local"
SSH_AUTHORIZED_FILE="authorized_keys"

ENUM_TARGET=0
ENUM_TARGET_VPS=0
ENUM_TARGET_LOCAL=1

## choose target configuration
if [ -z "$HARDWARE_TARGET" ]; then
	echo "HARDWARE_TARGET is not set, please set it to vps or local"
	exit 1
fi

if [ "$(echo "$HARDWARE_TARGET" | tr '[:upper:]' '[:lower:]')" != "$TARGET_VPS" ] \
	&& [ "$(echo "$HARDWARE_TARGET" | tr '[:upper:]' '[:lower:]')" != "$TARGET_LOCAL" ]; then
	echo "HARDWARE_TARGET is not set to vps or local, please set it to vps or local"
	exit 1
fi

## install dependencies needed for the installation
apt install -y \
	e2fsprogs \
	dosfstools \
	dialog \
	apt-utils \
	debootstrap

## partition disk
if [ "$(echo "$HARDWARE_TARGET" | tr '[:upper:]' '[:lower:]')" = "$TARGET_VPS" ]; then
	ENUM_TARGET=$ENUM_TARGET_VPS
	cp config_vps.sh ./resources/config.sh
	source ./config_vps.sh
	./disk_vps_partitioner.sh
else
	ENUM_TARGET=$ENUM_TARGET_LOCAL
	cp config_local.sh ./resources/config.sh
	source ./config_local.sh
	./disk_local_partitioner.sh
fi

## install debian
debootstrap --arch amd64 $HARDWARE_DEBIAN_VERSION /mnt $HARDWARE_DEBIAN_REPOSITORY

## mount system
mount -v --bind /dev /mnt/dev
mount -vt devpts /dev/pts /mnt/dev/pts
mount -vt proc /proc /mnt/proc
mount -vt sysfs /sys /mnt/sys
mount -vt tmpfs /run /mnt/run

## improve script utils mount partitions
echo "" >> /utils_mount.sh
echo "mount -v --bind /dev /mnt/dev" >> /utils_mount.sh
echo "mount -vt devpts /dev/pts /mnt/dev/pts" >> /utils_mount.sh
echo "mount -vt proc /proc /mnt/proc" >> /utils_mount.sh
echo "mount -vt sysfs /sys /mnt/sys" >> /utils_mount.sh
echo "mount -vt tmpfs /run /mnt/run" >> /utils_mount.sh
echo "# comment the following line if you won't enter in the system" >> /utils_mount.sh
echo "chroot /mnt /bin/bash" >> /utils_mount.sh

## copy files in the system
echo "$USER_SSH_KEY" > resources/$SSH_AUTHORIZED_FILE
cp -r internal_scripts /mnt/tmp/internal_scripts
cp -r resources /mnt/tmp/resources

echo "/tmp/internal_scripts/entrypoint.sh \
	$ENUM_TARGET \
	$USER_PASSWORD" | chroot /mnt /bin/bash

./partition_unmounter.sh $ENUM_TARGET

## remove files
if [ "$(echo "$HARDWARE_REMOVER" | tr '[:upper:]' '[:lower:]')" = "yes" ]; then
	cd /tmp
	sudo rm -rf /tmp/hardware
fi