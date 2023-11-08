#!/bin/bash

# args
NAMESPACE=$1
DATABASE=$2
USER_NAME=$3

read -s -p "Set your postgres user password: " USER_PASSWORD

POSTGRES_PASSWORD=$(sudo kubectl get secret --namespace database postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)

sudo kubectl run postgresql-client --rm --tty -i \
	--restart='Never' \
	--namespace database \
	--image docker.io/bitnami/postgresql:16.0.0-debian-11-r13 \
	--env="PGPASSWORD=$POSTGRES_PASSWORD" \
	--command -- /bin/bash -c "
(
	echo \"CREATE DATABASE $DATABASE;\"
	echo \"CREATE USER $USER_NAME WITH ENCRYPTED PASSWORD '$USER_PASSWORD';\"
	echo \"GRANT ALL PRIVILEGES ON DATABASE $DATABASE TO $USER_NAME;\"
) | psql --host postgresql -U postgres -p 5432"

sudo kubectl create secret generic postgres-$USER_NAME-crds \
	--from-literal=username=$(echo -n "$USER_NAME" | base64) \
	--from-literal=password=$(echo -n "$USER_PASSWORD" | base64) \
	--namespace $NAMESPACE

echo "secret postgres-$USER_NAME-crds created in namespace $NAMESPACE"