#!/bin/bash

## Install debian packages
sudo apt update && sudo apt upgrade -y
sudo apt install curl -y
sudo apt install git -y

## Install k3s
# k3s: https://docs.k3s.io/
HOMEPATH=`realpath ~`
echo "export KUBECONFIG=$HOMEPATH/.kube/config" >> $HOMEPATH/.bashrc
mkdir -p $HOMEPATH/.kube
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.28.3-rc2+k3s2" sh -
sudo kubectl config view --raw > $HOMEPATH/.kube/config
chmod 600 $HOMEPATH/.kube/config

## Install helm
# helm: https://helm.sh/docs/
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
