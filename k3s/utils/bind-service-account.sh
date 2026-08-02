#!/bin/bash

# Grants a ServiceAccount already created by service-account.sh rights in
# an *additional* namespace, via a RoleBinding referencing the shared
# "ci-deployer" ClusterRole. Use this instead of running service-account.sh
# again for the second namespace — that would create a second, unneeded
# ServiceAccount/Secret pair instead of reusing the one you already have.

# Arguments
TARGET_NAMESPACE=$1   # namespace to grant access into
SA_NAMESPACE=$2        # namespace the ServiceAccount actually lives in
SERVICE_ACCOUNT_NAME=$3

cat <<EOF | sudo kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: ${SERVICE_ACCOUNT_NAME}-binding
  namespace: ${TARGET_NAMESPACE}
subjects:
  - kind: ServiceAccount
    name: ${SERVICE_ACCOUNT_NAME}
    namespace: ${SA_NAMESPACE}
roleRef:
  kind: ClusterRole
  name: ci-deployer
  apiGroup: rbac.authorization.k8s.io
EOF
