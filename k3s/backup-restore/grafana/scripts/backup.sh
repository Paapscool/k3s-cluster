#!/bin/bash

# Build variables
CURRENT_FOLDER=$(dirname $0)
HISTORY_FILE=$CURRENT_FOLDER/deleted_backup_histories.log
GRAFANA_POD_NAME=`sudo kubectl get pods -n monitoring | grep "prometheus-grafana" | awk '{print $1}'`
BACKUP_DIR=`realpath $CURRENT_FOLDER/..`
BUILD_GRAFANA_CFG_FILE_PATH=`sudo kubectl exec $GRAFANA_POD_NAME -n monitoring -- sh -c "env | grep GF_PATHS_CONFIG= | sed 's/GF_PATHS_CONFIG=//'"`
BUILD_GRAFANA_DATA_PATH=`sudo kubectl exec $GRAFANA_POD_NAME -n monitoring -- sh -c "env | grep GF_PATHS_DATA= | sed 's/GF_PATHS_DATA=//'"`
## Créer un répertoire de sauvegarde avec la date actuelle
BUILD_CURRENT_DATE=`date +%Y-%m-%d`
BUILD_BACKUP_PATH="$BACKUP_DIR/grafana_backup_$BUILD_CURRENT_DATE"
mkdir -p $BUILD_BACKUP_PATH

# Backup process

## Copy plugins folder
sudo kubectl cp $GRAFANA_POD_NAME:${BUILD_GRAFANA_DATA_PATH}plugins $BUILD_BACKUP_PATH/plugins -n monitoring

## Dump database
sudo kubectl exec $GRAFANA_POD_NAME -n monitoring -- sh -c 'cp '$BUILD_GRAFANA_DATA_PATH'grafana.db /tmp/grafana.db'
sudo kubectl cp $GRAFANA_POD_NAME:/tmp/grafana.db $BUILD_BACKUP_PATH/grafana.db -n monitoring

## Compress save folder
tar -czvf $BUILD_BACKUP_PATH.tar.gz --directory=$BUILD_BACKUP_PATH plugins grafana.db

## Remove saved folder
rm -rf $BUILD_BACKUP_PATH

# Remove backup older than 7 days
find $BACKUP_DIR -maxdepth 1 -name "*.tar.gz" -mtime +7 -type f -print -delete >> $HISTORY_FILE


echo "Grafana backup are done inside $BUILD_BACKUP_PATH.tar.gz"
