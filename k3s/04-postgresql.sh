#!/bin/bash

# Global variables
FOLDER_KUBECONFIG="kubeconfig"

# Build variables
read -s -p "Set your postgresql user password: " BUILD_USER_PASSWORD

sudo kubectl create ns database
sudo kubectl config set-context --current --namespace=database

# chart helm values: https://github.com/bitnami/charts/blob/main/bitnami/postgresql/values.yaml
REGISTRY_NAME=registry-1.docker.io
REPOSITORY_NAME=bitnamicharts
helm install postgresql oci://$REGISTRY_NAME/$REPOSITORY_NAME/postgresql --namespace database \
	--set global.storageClass=longhorn \
	--set postgresqlDataDir=/postgresql/data \
	--set primary.persistence.mountPath=/postgresql \
	--set primary.persistentVolumeClaimRetentionPolicy.enabled=true \
	--set primary.hostNetwork=true \
	--set primary.labels.app=postgresql \
	--set primary.labels.name=postgresql \
	--set backup.enabled=true \
	--set backup.cronjob.storage.mountPath=/postgresql/pgdump \
	--set auth.postgresPassword=$BUILD_USER_PASSWORD
