#!/bin/bash

sudo kubectl create ns longhorn-system
sudo kubectl config set-context --current --namespace=longhorn-system

helm repo add longhorn https://charts.longhorn.io
helm repo update

# Chart helm values: https://github.com/longhorn/longhorn/blob/master/chart/values.yaml
helm install longhorn longhorn/longhorn --namespace longhorn-system \
	--set persistance.defaultClassReplicaCount=1 \
	--set persistance.defaultDataLocality=best-effort \
	--set csi.attacherReplicaCount=1 \
	--set csi.provisionerReplicaCount=1 \
	--set csi.resizerReplicaCount=1 \
	--set csi.snapshotterReplicaCount=1 \
	--set longhornUI.replicas=1 \
	--set defaultSettings.createDefaultDiskLabeledNodes=true \
	--set defaultSettings.defaultDataPath=/database \
	--set defaultSettings.defaultReplicaCount=1 \
	--set defaultSettings.replicaSoftAntiAffinity=true \
	--set defaultSettings.defaultDataLocality=best-effort \
	--set defaultSettings.priorityClass=high-priority \
	--set defaultSettings.guaranteedInstanceManagerCPU=12 \
	--set defaultSettings.storageMinimalAvailablePercentage=0 \
	--set defaultSettings.storageReservedPercentageForDefaultDisk=10 \
	--set defaultSettings.storageOverProvisioningPercentage=600

# change default storage class
sudo cp /var/lib/rancher/k3s/server/manifests/local-storage.yaml /var/lib/rancher/k3s/server/manifests/custom-local-storage.yaml
sudo sed -i -e "s/storageclass.kubernetes.io\/is-default-class: \"true\"/storageclass.kubernetes.io\/is-default-class: \"false\"/g" /var/lib/rancher/k3s/server/manifests/custom-local-storage.yaml
