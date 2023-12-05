#!/bin/bash

# helm uninstaller
helm --namespace cert-manager delete cert-manager
helm --namespace monitoring delete prometheus
helm --namespace monitoring delete loki
helm --namespace database delete postgresql
helm --namespace longhorn-storage delete longhorn
rm -rf ~/.local/share/helm
rm -rf ~/.config/helm
rm -rf ~/.cache/helm

# kube uninstaller
sudo rm -rf /dev/longhorn
sudo rm /usr/local/bin/helm
/usr/local/bin/k3s-uninstall.sh
rm -rf ~/.kube
rm -rf ~/backup
rm -rf ~/utils

# remove installer files
cd ../ && rm -rf k3s

# remove extra files
rm -rf /var/lib/kubelet
rm -rf /run/k3s/containerd
sudo rm -rf  /run/longhorn-iscsi.lock
sudo rm -rf  /run/containerd/

exit

