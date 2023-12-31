#!/bin/bash

# args
NAMESPACE=$1
DATABASE=$2
USER_NAME=$3
ADMIN=$4
CREATE_DATABASE=$5

read -s -p "Set your user $USER_NAME password: " USER_PASSWORD

POSTGRES_PASSWORD=$(sudo kubectl get secret --namespace database postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)

sudo kubectl run postgresql-client --rm --tty -i \
	--restart='Never' \
	--namespace database \
	--image docker.io/bitnami/postgresql:16.0.0-debian-11-r13 \
	--env="PGPASSWORD=$POSTGRES_PASSWORD" \
	--command -- /bin/bash -c "
(
	if [ \"$CREATE_DATABASE\" = \"true\" || \"$CREATE_DATABASE\" = \"TRUE\" ]; then
		echo \"CREATE DATABASE $DATABASE;\"
	fi
	echo \"CREATE USER $USER_NAME WITH ENCRYPTED PASSWORD '$USER_PASSWORD';\"
	echo \"GRANT CONNECT ON DATABASE $DATABASE TO $USER_NAME;\"
	if [ \"$ADMIN\" = \"true\" || \"$ADMIN\" = \"TRUE\" ]; then
		echo \"GRANT ALL PRIVILEGES ON DATABASE $DATABASE TO $USER_NAME;\"
	fi
) | psql --host postgresql -U postgres -p 5432"

sudo kubectl create secret generic postgres-$USER_NAME-crds \
	--from-literal=username="$USER_NAME" \
	--from-literal=password="$USER_PASSWORD" \
	--namespace $NAMESPACE

echo "secret postgres-$USER_NAME-crds created in namespace $NAMESPACE"