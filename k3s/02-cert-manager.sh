#!/bin/bash

sudo kubectl create ns cert-manager
sudo kubectl config set-context --current --namespace=cert-manager

helm repo add jetstack https://charts.jetstack.io
helm repo update

# Chart helm values: https://github.com/cert-manager/cert-manager/blob/master/deploy/charts/cert-manager/values.yaml
helm install cert-manager jetstack/cert-manager --namespace cert-manager \
	--version v1.13.1 \
	--set installCRDs=true
