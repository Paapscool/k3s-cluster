#!/bin/bash

# Arguments
NAMESPACE=$1
SERVICE_ACCOUNT_NAME=$2

# Pattern matching list
REPLACE_NAMESPACE=VAR_NAMESPACE_REPLACER
REPLACE_SERVICE_ACCOUNT_NAME=VAR_SERVICE_ACCOUNT_NAME_REPLACER

FILE=$SERVICE_ACCOUNT_NAME.yaml

cp ./deployments/account.yaml ./$FILE

sed -i 's/'"$REPLACE_NAMESPACE"'/'"$NAMESPACE"'/g' ./$FILE
sed -i 's/'"$REPLACE_SERVICE_ACCOUNT_NAME"'/'"$SERVICE_ACCOUNT_NAME"'/g' ./$FILE

sudo kubectl apply -f ./$FILE

rm ./$FILE

(
	echo "to retrieve your KUBERNETES SECRET for the service account, run the following command:"
	echo "sudo kubectl get secret $SERVICE_ACCOUNT_NAME-token -o yaml -n $NAMESPACE"
)