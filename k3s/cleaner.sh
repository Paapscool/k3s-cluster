#!/bin/bash

helm --namespace cert-manager delete cert-manager
helm --namespace monitoring delete prometheus
helm --namespace monitoring delete loki
helm --namespace database delete postgresql
helm --namespace longhorn-storage delete longhorn
rm -rf ~/.local/share/helm
rm -rf ~/.config/helm
rm -rf ~/.cache/helm
rm -rf ~/.kube
rm -rf ~/backup
sudo rm -rf /dev/longhorn
sudo rm /usr/local/bin/helm
/usr/local/bin/k3s-uninstall.sh

cd ../ && rm -rf kube-master

exit