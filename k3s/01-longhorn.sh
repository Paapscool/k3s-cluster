#!/bin/bash

sudo kubectl create ns longhorn-system
sudo kubectl config set-context --current --namespace=longhorn-system

sudo kubectl apply -f kubeconfig/resource-quota.yaml --namespace longhorn-system

helm repo add longhorn https://charts.longhorn.io
helm repo update

# Chart helm values: https://github.com/longhorn/longhorn/blob/master/chart/values.yaml
helm install longhorn longhorn/longhorn --namespace longhorn-system \
	--set csi.snapshotterReplicaCount=1 \
	--set longhornUI.replicas=1 \
	--set defaultSettings.defaultReplicaCount=1 \
	--set defaultSettings.defaultDataPath=/data \
	--set defaultSettings.replicaSoftAntiAffinity=true \
	--set defaultSettings.storageReservedPercentageForDefaultDisk=0 \
	--set defaultSettings.storageMinimalAvailablePercentage=0 \
	--set persistence.defaultClassReplicaCount=2 \
	--set persistence.defaultClass=false
