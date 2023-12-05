#!/bin/bash

# Arguments
EMAIL=$1

# Pattern matching list
REPLACE_EMAIL=VAR_EMAIL_REPLACER
REPLACE_GRAFANA_HOST=VAR_GRAFANA_HOST_REPLACER
REPLACE_GRAFANA_CERT_SECRET=VAR_GRAFANA_CERT_SECRET_REPLACER
REPLACE_LONGHORN_HOST=VAR_LONGHORN_HOST_REPLACER
REPLACE_LONGHORN_CERT_SECRET=VAR_LONGHORN_CERT_SECRET_REPLACER
REPLACE_CERT_DOMAIN=VAR_CERT_DOMAIN_REPLACER
REPLACE_CERT_ORGANIZATION=VAR_CERT_ORGANIZATION_REPLACER
REPLACE_CERT_COUNTRY=VAR_CERT_COUNTRY_REPLACER
REPLACE_CERT_CITY=VAR_CERT_CITY_REPLACER
REPLACE_CERT_PROVINCE=VAR_CERT_PROVINCE_REPLACER

# Global variables
FOLDER_KUBECONFIG="kubeconfig"

if [ "$(echo "$INGRESS_GRAFANA" | tr '[:upper:]' '[:lower:]')" = "yes" ]; then
  echo "use ingress for grafana"
  INSTALL_GRAFANA=1
  read -p "Set your Grafana host domain: " GRAFANA_HOST
else
  echo "use port-forward for grafana"
fi

if [ "$(echo "$INGRESS_LONGHORN" | tr '[:upper:]' '[:lower:]')" = "yes" ]; then
  echo "use ingress for longhorn"
  INSTALL_LONGHORN=1
  read -p "Set your Longhorn host domain: " LONGHORN_HOST
else
  echo "use port-forward for longhorn"
fi

if [ "INSTALL_GRAFANA" = "1" ] || [ "INSTALL_LONGHORN" = "1" ]; then
  read -p "Set your cert domain: " CERT_DOMAIN
  read -p "Set your cert organization: " CERT_ORGANIZATION
  read -p "Set your cert country: " CERT_COUNTRY
  read -p "Set your cert city: " CERT_CITY
  read -p "Set your cert province: " CERT_PROVINCE
fi

# Update configuration
sed -i 's/'"$REPLACE_EMAIL"'/'"$EMAIL"'/g' ./$FOLDER_KUBECONFIG/cluster-issuer.yaml

# move utils folder
mv utils ~/utils

# prepare os extra configuration
sudo timedatectl set-timezone Europe/Paris

# run scripts
./00-kube-install.sh

./01-longhorn.sh
if [ "INSTALL_LONGHORN" = "1" ]; then
  BUILD_LONGHORN_CERT_SECRET=`echo $LONGHORN_HOST | sed 's/\./-/g'`
  sed -i 's/'"$REPLACE_CERT_DOMAIN"'/'"$CERT_DOMAIN"'/g' ./$FOLDER_KUBECONFIG/longhorn-ingress.yaml
  sed -i 's/'"$REPLACE_CERT_ORGANIZATION"'/'"$CERT_ORGANIZATION"'/g' ./$FOLDER_KUBECONFIG/longhorn-ingress.yaml
  sed -i 's/'"$REPLACE_CERT_COUNTRY"'/'"$CERT_COUNTRY"'/g' ./$FOLDER_KUBECONFIG/longhorn-ingress.yaml
  sed -i 's/'"$REPLACE_CERT_CITY"'/'"$CERT_CITY"'/g' ./$FOLDER_KUBECONFIG/longhorn-ingress.yaml
  sed -i 's/'"$REPLACE_CERT_PROVINCE"'/'"$CERT_PROVINCE"'/g' ./$FOLDER_KUBECONFIG/longhorn-ingress.yaml
  sed -i 's/'"$REPLACE_LONGHORN_HOST"'/'"$LONGHORN_HOST"'/g' ./$FOLDER_KUBECONFIG/longhorn-ingress.yaml
  sed -i 's/'"$REPLACE_LONGHORN_CERT_SECRET"'/'"$BUILD_LONGHORN_CERT_SECRET"'/g' ./$FOLDER_KUBECONFIG/longhorn-ingress.yaml
  sudo kubectl apply -f ./$FOLDER_KUBECONFIG/longhorn-ingress.yaml
fi

./02-cert-manager.sh
sudo kubectl apply -f ./$FOLDER_KUBECONFIG/cluster-issuer.yaml

./03-monitoring.sh
if [ "INSTALL_GRAFANA" = "1" ]; then
  BUILD_GRAFANA_CERT_SECRET=`echo $GRAFANA_HOST | sed 's/\./-/g'`
  sed -i 's/'"$REPLACE_CERT_DOMAIN"'/'"$CERT_DOMAIN"'/g' ./$FOLDER_KUBECONFIG/grafana-ingress.yaml
  sed -i 's/'"$REPLACE_CERT_ORGANIZATION"'/'"$CERT_ORGANIZATION"'/g' ./$FOLDER_KUBECONFIG/grafana-ingress.yaml
  sed -i 's/'"$REPLACE_CERT_COUNTRY"'/'"$CERT_COUNTRY"'/g' ./$FOLDER_KUBECONFIG/grafana-ingress.yaml
  sed -i 's/'"$REPLACE_CERT_CITY"'/'"$CERT_CITY"'/g' ./$FOLDER_KUBECONFIG/grafana-ingress.yaml
  sed -i 's/'"$REPLACE_CERT_PROVINCE"'/'"$CERT_PROVINCE"'/g' ./$FOLDER_KUBECONFIG/grafana-ingress.yaml
  sed -i 's/'"$REPLACE_GRAFANA_HOST"'/'"$GRAFANA_HOST"'/g' ./$FOLDER_KUBECONFIG/grafana-ingress.yaml
  sed -i 's/'"$REPLACE_GRAFANA_CERT_SECRET"'/'"$BUILD_GRAFANA_CERT_SECRET"'/g' ./$FOLDER_KUBECONFIG/grafana-ingress.yaml
  sudo kubectl apply -f ./$FOLDER_KUBECONFIG/grafana-ingress.yaml
fi

./04-postgresql.sh
