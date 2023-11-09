#!/bin/bash

## args
ENUM_TARGET=$1
USER_PASSWORD=$2

## enum
ENUM_TARGET_VPS=0
ENUM_TARGET_LOCAL=1

source ../resources/config.sh

## update system
apt update
apt upgrade -y

apt install -y \
	dialog \
	apt-utils \
	locales \
	sudo \
	policycoreutils

# configure locale
sed -i 's/# C.UTF-8 UTF-8/C.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

# configure timezone
sudo timedatectl set-timezone Europe/Paris

## configure bootloaders
if [ "$ENUM_TARGET" = "$ENUM_TARGET_VPS" ]; then
	./install_vps_bootloader.sh
else
	./install_local_bootloader.sh
fi

## Install tools packages
# ethtool is used to configure the network interface
# openssh-server is used to have a ssh server
# openssl is used to manage certificate (for ssh)
# vim is used to edit files
# fail2ban is used to ban ip after too many failed login
# wget is used to download files
# gnupg2 is used to manage gpg keys
# apache2-utils is used to manage htpasswd (use later with k3s)
# open-iscsi is used to mount iscsi disk (use later with k3s)
apt install -y \
	ethtool \
	openssh-server \
	openssl \
	vim \
	fail2ban \
	wget \
	gnupg2 \
	apache2-utils \
	open-iscsi

## network configuration
# /etc/networks
echo "default         0.0.0.0" > /etc/networks
echo "loopback        127.0.0.1" >> /etc/networks
echo "link-local      169.254.0.0" >> /etc/networks
echo "" >> /etc/networks

# /etc/hostname setter and keep persistant
echo "$HARDWARE_SUB_DOMAIN.$HARDWARE_DOMAIN_NAME" > /etc/hostname

# /etc/host.conf
echo "order hosts,bind" > /etc/host.conf
echo "multi on" >> /etc/host.conf

# /etc/hosts
echo "127.0.0.1       localhost" > /etc/hosts
echo "127.0.1.1       $HARDWARE_SUB_DOMAIN.$HARDWARE_DOMAIN_NAME    $HARDWARE_SUB_DOMAIN" >> /etc/hosts
echo "" >> /etc/hosts
echo "::1             localhost ip6-localhost ip6-loopback" >> /etc/hosts
echo "" >> /etc/hosts
echo "ff02::1         ip6-allnodes" >> /etc/hosts
echo "ff02::2         ip6-allrouters" >> /etc/hosts
echo "" >> /etc/hosts

# setup fail2ban
mkdir /etc/systemd/system/fail2ban.service.d

SOURCE_FAIL2BAN_PATH=../resources/fail2ban
mv $SOURCE_FAIL2BAN_PATH/fail2ban.local /etc/fail2ban/fail2ban.local
mv $SOURCE_FAIL2BAN_PATH/jail.local /etc/fail2ban/jail.local
mv $SOURCE_FAIL2BAN_PATH/nftables-common.local /etc/fail2ban/action.d/nftables-common.local
mv $SOURCE_FAIL2BAN_PATH/sendmail-common.local /etc/fail2ban/action.d/sendmail-common.local
mv $SOURCE_FAIL2BAN_PATH/override.conf /etc/systemd/system/fail2ban.service.d/override.conf

# setup nftables
SOURCE_NFT_PATH=../resources/nftables
mv $SOURCE_NFT_PATH/nftables.conf /etc/nftables.conf
mv $SOURCE_NFT_PATH/nftables.d /etc/nftables.d

## user configuration
# create the new user
sudo adduser $HARDWARE_USER_NAME --gecos "$HARDWARE_USER_FULL_NAME,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "$HARDWARE_USER_NAME:`printf "%s" "$USER_PASSWORD" | base64 --decode`" | sudo chpasswd

# create new group
groupadd $HARDWARE_USER_GROUP

# attach group for the user
usermod -aG root,sudo,adm,$HARDWARE_USER_GROUP

## Update ssh configuration
# adding ssh key
mkdir /home/$HARDWARE_USER_NAME/.ssh
chmod 700 /home/$HARDWARE_USER_NAME/.ssh
mv ../resources/authorized_keys /home/$HARDWARE_USER_NAME/.ssh/authorized_keys 
chmod 600 /home/$HARDWARE_USER_NAME/.ssh/authorized_keys
chown -R $HARDWARE_USER_NAME:$HARDWARE_USER_NAME /home/$HARDWARE_USER_NAME/.ssh

# configure sshd
SSH_CONFIG_PATH=/etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' $SSH_CONFIG_PATH
sed -i 's/#Port 22/Port 22/' $SSH_CONFIG_PATH
sed -i 's/#LogLevel INFO/LogLevel INFO/' $SSH_CONFIG_PATH
sed -i 's/#SyslogFacility AUTH/SyslogFacility AUTH/' $SSH_CONFIG_PATH
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' $SSH_CONFIG_PATH
echo "AllowUsers $HARDWARE_USER_NAME" >> $SSH_CONFIG_PATH
echo "AllowGroups $HARDWARE_USER_GROUP" >> $SSH_CONFIG_PATH

# remove override ssh cloud config
rm -f /etc/ssh/sshd_config.d/*

## Start services
systemctl enable ssh
systemctl enable fail2ban
systemctl enable nftables