#!/bin/bash

read -s -p "Set your Grafana admin password: " GRAFANA_PASSWORD

sudo kubectl create ns monitoring
sudo kubectl config set-context --current --namespace=monitoring

## prometheus and grafana installation
# Chart helm values: https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/values.yaml
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring \
	--set grafana.adminPassword="$GRAFANA_PASSWORD" \
	--set grafana.persistence.enabled=true \
	--set grafana.persistence.size=4Gi \
	--set grafana.defaultDashboardsTimezone=Europe/Paris

## loki installation
helm repo add grafana https://grafana.github.io/helm-charts
helm upgrade --install loki grafana/loki-stack --namespace monitoring

(
	echo "to retrieve the grafana admin password, run the following command:"
	echo "sudo kubectl get secret --namespace monitoring prometheus-grafana -o jsonpath=\"{.data.admin-password}\" | base64 --decode ; echo"
	echo
	echo "to retrieve the grafana url, run the following command:"
	echo "sudo kubectl get ingress --namespace monitoring grafana-ingress"
	echo
	echo "loki datasource: http://loki:3100"
	echo "alertmanager datasource: http://prometheus-kube-prometheus-alertmanager:9093"
	echo
	echo "Configure your grafana"
	echo "create a backup of grafana: https://grafana.com/docs/grafana/latest/administration/back-up-grafana/"
	echo
	echo "Enjoy :)"
)

## Grafana backup installation
mkdir -p ~/backup
cp -r backup-restore/grafana ~/backup/grafana
# Create cronjob script
BUILD_SCRIPT_PATH=`realpath ~/backup/grafana/scripts/backup.sh`
CRONJOB_SCRIPT_NAME=grafana-backup
echo "#!/bin/sh" > $CRONJOB_SCRIPT_NAME
echo "" >> $CRONJOB_SCRIPT_NAME
echo "$BUILD_SCRIPT_PATH" >> $CRONJOB_SCRIPT_NAME
sudo mv $CRONJOB_SCRIPT_NAME /etc/cron.daily/$CRONJOB_SCRIPT_NAME
sudo chmod +x /etc/cron.daily/$CRONJOB_SCRIPT_NAME
sudo chown root:root /etc/cron.daily/$CRONJOB_SCRIPT_NAME

echo "Grafana backup is installed with 7 days retention."
