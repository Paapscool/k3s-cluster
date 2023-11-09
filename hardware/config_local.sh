#!/bin/bash

## configuration hardware installation for local server
# HARDWARE_TARGET vps | local | ...
HARDWARE_TARGET=local

## HARDWARE DISK PARTITIONER
# HARDWARE_DISK_NAME sda | sdb | ...
# be sure from your rescue session to select the right disk
HARDWARE_DISK_NAME=sda
# HARDWARE_RESCUE_DISK_NAME is used only for local installation
# it define the name of the rescue disk and used to switch the swap partition
# ignored for the vps installation
HARDWARE_RESCUE_DISK_NAME=sdb
# HARDWARE_VPS_BOOT_SIZE is used only for vps installation
#* HARDWARE_VPS_BOOT_SIZE=
# HARDWARE_LOCAL_SWAP_SIZE is used only for local installation
HARDWARE_LOCAL_SWAP_SIZE=2G
HARDWARE_EFI_SIZE=560M
HARDWARE_FS_SIZE=8G
# HARDWARE_PERSISTENT_SIZE auto (for full available space allocation)
# basicly this storage should use for the persistent storage
# if value is different of auto, it will be used as size
HARDWARE_PERSISTENT_SIZE=auto

## DEBIAN CONFIGURATION
HARDWARE_DEBIAN_REPOSITORY=http://ftp.fr.debian.org/debian/
HARDWARE_DEBIAN_VERSION=bookworm
HARDWARE_SUB_DOMAIN=<sub-domain>
HARDWARE_DOMAIN_NAME=<domain>
# DEBIAN USER INFORMATION
# password should be prompt
HARDWARE_USER_FULLNAME=<user-fullname>
HARDWARE_USER_NAME=<user-name>
HARDWARE_USER_GROUP=<user-group>
