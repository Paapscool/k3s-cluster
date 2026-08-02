#!/bin/bash

# Creates a ServiceAccount + long-lived token Secret in NAMESPACE, and
# grants it the shared "ci-deployer" ClusterRole scoped to that namespace
# only (via a RoleBinding, not a ClusterRoleBinding). To grant this same
# ServiceAccount rights in another namespace too, use
# bind-service-account.sh instead of running this script again with a
# different namespace — running it again here would create a second,
# unneeded ServiceAccount/Secret pair.

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