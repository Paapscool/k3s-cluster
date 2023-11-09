#!/bin/bash

# This script configure the root session for secure the server

ROOT_PASSWORD=$1

# set root password
echo
(
  printf "%s" "$ROOT_PASSWORD" | base64 --decode
  echo
  printf "%s" "$ROOT_PASSWORD" | base64 --decode
) | passwd

# Update ssh configuration
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

printf "\n--------------------  user $USER_NAME created  --------------------\n\n"