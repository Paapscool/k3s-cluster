#!/bin/bash

# args
TARGET=$1

# enum
ENUM_TARGET_GRAFANA=grafana
ENUM_TARGET_LONGHORN=longhorn

if [ -z "$TARGET" ] || [ "$TARGET" != "$ENUM_TARGET_LONGHORN" ] && [ "$TARGET" != "$ENUM_TARGET_GRAFANA" ] ; then
	echo "Usage: $0 <target>"
	echo "target: $ENUM_TARGET_GRAFANA | $ENUM_TARGET_LONGHORN"
	exit 1
fi

if [ "$TARGET" == "$ENUM_TARGET_GRAFANA" ]; then
	SERVICE_NAME=prometheus-grafana
	NAMESPACE=monitoring
	PORT=80
	EXPOSED_PORT=5080
elif [ "$TARGET" == "$ENUM_TARGET_LONGHORN" ]; then
	SERVICE_NAME=longhorn-frontend
	NAMESPACE=longhorn-system
	PORT=80
	EXPOSED_PORT=5081
fi

IP=`sudo kubectl get service $SERVICE_NAME -o jsonpath='{.spec.clusterIP}' -n $NAMESPACE`
echo "from other terminal, run the following command:"
echo ""
echo "ssh -L$EXPOSED_PORT:$IP:$PORT user-ssh@server-ssh"
echo ""
echo "then open http://localhost:$EXPOSED_PORT"
sudo kubectl --namespace $NAMESPACE port-forward service/$SERVICE_NAME $EXPOSED_PORT:$PORT