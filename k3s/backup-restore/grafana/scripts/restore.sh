#!/bin/bash

# Arguments
GRAFANA_POD_NAME=$1
BACKUP_FILE_NAME=$3

# Build variables
BACKUP_DIR=`realpath ../`
BUILD_GRAFANA_CFG_FILE_PATH=`sudo kubectl exec $GRAFANA_POD_NAME -n monitoring -- sh -c "env | grep GF_PATHS_CONFIG= | sed 's/GF_PATHS_CONFIG=//'"`
BUILD_GRAFANA_DATA_PATH=`sudo kubectl exec $GRAFANA_POD_NAME -n monitoring -- sh -c "env | grep GF_PATHS_DATA= | sed 's/GF_PATHS_DATA=//'"`

# Global variables
RESTORE_FOLDER=restore_grafana

# Restore process

## Create restore folder
mkdir -p $RESTORE_FOLDER

## Untar file
tar -xzvf $BACKUP_DIR/$BACKUP_FILE_NAME -C $RESTORE_FOLDER

## Copy plugin folder
sudo kubectl cp $RESTORE_FOLDER/plugins $GRAFANA_POD_NAME:${BUILD_GRAFANA_DATA_PATH}plugins -n monitoring

## Restore database
sudo kubectl cp $RESTORE_FOLDER/grafana.db $GRAFANA_POD_NAME:/tmp/grafana.db -n monitoring
sudo kubectl exec $GRAFANA_POD_NAME -n monitoring -- sh -c 'cp /tmp/grafana.db '$BUILD_GRAFANA_DATA_PATH'grafana.db'

## Removed extracted folder
rm -rf $RESTORE_FOLDER

echo "Restore grafana with success !"
