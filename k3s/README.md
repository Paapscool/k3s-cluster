# K3S

The main motivation is to have a full control on the stack for deployments and managements applications with an hosted kubernetes. I have always been afraid of linking my bank card to a cloud provider auto scalable :smile:

But kube is a enjoyable tool for manage and deploy applications. So, I decided to create a kubernetes cluster on my own server, like a pro :sunglasses:

Keep in mind, this is an exploration project, for deploy my applications, improve my understanding of kubernetes and explore new horizons. I'm not a kubernetes expert and your feedbacks / contributions are welcome.

Target usage: Production ready

## Prerequise

To run scripts, you need to have a debian server installed with ssh access. If you start from scratch, you can read the [hardware section](../hardware/README.md) to install your first server.

Too, you need to have:

- a domain name and a DNS server to manage your domain name
- a firewall configuration to open ports for your services
- an empty and specific disk for persistent storage
- apache2-utils package for generate password if you want to use basic authentification
- open-iscsi package for use a longhorn persistent storage

## What does the script inside

At this time, the scripts install a kubernetes cluster (k3s) for a master node. The master node is the main node for manage the cluster and have a public IP. I don't have tested to add slave node, but it should work just in connecting the slave node to the master node (except for longhorn where you need to install it and configure it on each other node).

Details installation:

- K3S (with traefik)
- Helm
- Cert-manager for generate and certifiate ssl connections
- prometeus-community-stack for monitoring (with grafana and loki)
- longhorn to have a persistent storage on a empty and specific disk in `/database` path
- postgresql for database

## Install

For run the installation, go to k3s folder and run the following command:

``` bash
SERVER_HOST='<server-host>' \
SERVER_USER='<server-user>' \
make install
```

or

``` bash
make install
# prompt should ask you the server host and user
```

This command should copy the content folder to /tmp/k3s of your remote server. Then, from the /tmp/k3s folder, run the script with the following command:

``` bash
<$ ./entrypoint.sh 'your-email'
# By default the connection to grafana and longhorn dashboard is done by port-forwarding (kube + ssh)

<$ INGRESS_GRAFANA=YES INGRESS_LONGHORN=YES ./entrypoint.sh 'your-email'
# You can set environment variables to record an ingress on https (certified) for longhorn and grafana, but it's not secure for longhorn because not authentication process is configured.
# In this case, the script prompt you:
#  - the host domain to use for the specific ingress.
#  - the domain name to use for the certificate.
#  - the organization name to use for the certificate.
#  - the country name to use for the certificate.
#  - the city name to use for the certificate.
#  - the province name to use for the certificate.
# exemple with paapscool domain for grafana:
# host: monitoring.paapscool.fr
# domain: paapscool.fr
# organization: Paapscool
# country: FR
# city: MILLAU
# province: OCCITANIE
```

During the installation, the script prompt you for the following informations:

- grafana password for the default admin user
- postgresql password for the default admin user ('postgres')

## Uninstall

For run the uninstallation, go to /tmp/k3s folder and run the following command:

``` bash
# remove all components installed by the scripts
./cleaner.sh
```

## Complementary informations

### K3S / Traefik

:warning: Actually k3s `latest` expose an issue about the traefik version used fixed in the `v1.28.3-rc2+k3s2` version. This version is not available in the `stable` tag.

In the k3s api-resources, you can see custom resource definition (crd)'s traefik availables:

``` bash
# please, like documented by traefik, use the traefik.io/v1alpha1 version in your resources
<$ sudo kubectl api-resources | grep traefik

ingressroutes                                  traefik.containo.us/v1alpha1           true         IngressRoute
ingressroutetcps                               traefik.containo.us/v1alpha1           true         IngressRouteTCP
ingressrouteudps                               traefik.containo.us/v1alpha1           true         IngressRouteUDP
middlewares                                    traefik.containo.us/v1alpha1           true         Middleware
middlewaretcps                                 traefik.containo.us/v1alpha1           true         MiddlewareTCP
serverstransports                              traefik.containo.us/v1alpha1           true         ServersTransport
tlsoptions                                     traefik.containo.us/v1alpha1           true         TLSOption
tlsstores                                      traefik.containo.us/v1alpha1           true         TLSStore
traefikservices                                traefik.containo.us/v1alpha1           true         TraefikService
ingressroutes                                  traefik.io/v1alpha1                    true         IngressRoute
ingressroutetcps                               traefik.io/v1alpha1                    true         IngressRouteTCP
ingressrouteudps                               traefik.io/v1alpha1                    true         IngressRouteUDP
middlewares                                    traefik.io/v1alpha1                    true         Middleware
middlewaretcps                                 traefik.io/v1alpha1                    true         MiddlewareTCP
serverstransports                              traefik.io/v1alpha1                    true         ServersTransport
serverstransporttcps                           traefik.io/v1alpha1                    true         ServersTransportTCP
tlsoptions                                     traefik.io/v1alpha1                    true         TLSOption
tlsstores                                      traefik.io/v1alpha1                    true         TLSStore
traefikservices                                traefik.io/v1alpha1                    true         TraefikService
```

### HELM

N/A

### CERT-MANAGER

:warning: the installation use by default the production server for generate certificate.

For your tests, use the staging server: `https://acme-staging-v02.api.letsencrypt.org/directory` (defined in the cluster-issuer.yaml). It's really fast to get ban from the production server :smile:

Ready ? Use the production server: `https://acme-v02.api.letsencrypt.org/directory`

#### How to declare new ingress with ssl certificate

``` yaml
# example with paapscool domain for grafana
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt # cluster-issuer name
    cert-manager.io/common-name: monitoring.paapscool.fr # domain name
    cert-manager.io/subject-organizations: Paapscool # organization name
    cert-manager.io/subject-countries: FR # country name
    cert-manager.io/subject-localities: MILLAU # city name
    cert-manager.io/subject-provinces: OCCITANIE # province name
    traefik.ingress.kubernetes.io/frontend-entry-points: https
    traefik.ingress.kubernetes.io/redirect-entry-point: https
    traefik.ingress.kubernetes.io/redirect-permanent: "true"
  name: grafana-ingress
  namespace: monitoring
spec:
  ingressClassName: traefik
  rules:
  - host: monitoring.paapscool.fr # repeat domain name
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: prometheus-grafana # service name
            port:
              number: 80
  tls:
  - hosts:
    - monitoring.paapscool.fr # repeat domain name
    secretName: monitoring-paaapscool-fr-tls # secret name, convention seems to use the domain name with -tls suffix
```

### PROMETHEUS / GRAFANA

You could retrieve severals informations about grafana with the following command:

``` bash
# get password for admin user
<$ sudo kubectl get secret --namespace monitoring prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# get the grafana url
<$ sudo kubectl get ingress --namespace monitoring grafana-ingress
```

To define a new datasource, you need to use the following informations:

- name: loki
  url: `http://loki:3100`
- name: alert-manager
  url: `http://prometheus-kube-prometheus-alertmanager:9093`

A cron job is installed for create backup periodically (every days at 00:00). The backup is stored in the ~/backup-restore/grafana folder.
From the longhorn is configured, this process seems useless.

For running manually the backup, you can use the following command:

``` bash
<$ ~/backup-restore/grafana/scripts/backup.sh
# you can restore a backup with the following command:
# ./script grafana-pod-name backup-file-path
<$ ~/backup-restore/grafana/scripts/restore.sh `sudo kubectl get pods -o custom-columns=":metadata.name" -n monitoring | grep grafana` ~/backup-restore/grafana/grafana-backupfile-2021-09-26-00-00-01.tar.gz
```

Connect to the dashboard without ingress:

``` bash
# for grafana
<$ ~/utils/forwarder.sh grafana
```

### POSTGRESQL

Postgres is installed with a persistent storage. The data are stored in the /database folder by longhorn.

The user admin name is `postgres` and the password is defined during the installation.

The contact point inside the cluster is: `postgresql.database.svc.cluster.local`

If you need to connect an application to the database, you need to create a new credentials to avoid the admin credentials propagation.

``` bash
# first, store the password in a temporary environment variable
<$ export POSTGRES_PASSWORD=$(sudo kubectl get secret --namespace database postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
# create in a new client postgresql pod
# the new pod is removed after leaving the connection
<# sudo kubectl run postgresql-client --rm --tty -i --restart='Never' --namespace database --image docker.io/bitnami/postgresql:16.0.0-debian-11-r13 --env="PGPASSWORD=$POSTGRES_PASSWORD" --command -- /bin/bash
# create a new user
<$ createuser -U postgres USER_NAME -S -D -R -P --host postgresql
# create a new database
<$ createdb -U postgres DATABASE_NAME  -O USER_NAME --host postgresql

# don't forget to create a secret inside the kubernetes cluster for the new user and password with the associated namespace
kubectl create secret generic <nom-du-secret> --from-literal=username=$(echo -n "<votre-nom-d-utilisateur>" | base64) --from-literal=password=$(echo -n "<votre-mot-de-passe>" | base64) --namespace <votre-namespace>
```

Instead of, you could use the script to create a new user, database and namespaced secret:

``` bash
~/utils/postgresql_new_credentials.sh namespace database_name user_name
```

Finaly, if you need to create a pg client just to use psql command, use directly the following command:

``` bash
<$ sudo kubectl run postgresql-client --rm --tty -i --restart='Never' --namespace database --image docker.io/bitnami/postgresql:16.0.0-debian-11-r13 --env="PGPASSWORD=$POSTGRES_PASSWORD" --command -- psql --host postgresql -U postgres -d postgres -p 5432
```

#### How use secret for your deployment

``` yaml
  env:
   - name: PG_USER # example for user name key in your application
     valueFrom:
       secretKeyRef:
         name: postgres-<your-username>-crds # secret name
         key: username # key inside the secret
```

### LONGHORN

Connect to the dashboard without ingress:

``` bash
# for longhorn
<$ ~/utils/forwarder.sh longhorn
```

If no disk detected, you need to configure it manually:

- Go to the Node tab
- right on the node, select the Operation option and 'Edit node and disks'
- Add minimal Manager CPU Request to `1m`
- Name your disk
- Select the path (in the script case: `/database`)
- Select Storage Reserved to `0`
- Turn on Scheduling with `Enable`
- Save and quit.

Sometimes, volumes stay in detached state. You can try to attach it manually directly from the longhorn dashboard:

- Select the volume
- right on the volume, select the Operation option and 'Attach volume'

## Source guide

Many documentations help me to create this project. I try to list the most important here:

- [k3s on vps](https://www.grottedubarbu.fr/installation-de-k3s-sur-un-vps-ovh/)
- [k3s in HA mode](https://www.grottedubarbu.fr/k3s-multi-master/)
- [prometheus stack](https://blog.stephane-robert.info/post/monitoring-kubernetes-k3s-prometheus-grafana/)
- [loki](https://k3s.rocks/logging/)
- [cert-manager / letsencrypt](https://medium.com/avmconsulting-blog/encrypting-the-certificate-for-kubernetes-lets-encrypt-805d2bf88b2a)
- [cert-manager / letsencrypt 2](https://cert-manager.io/docs/installation/helm/)
- [longhorn](https://pongzt.com/post/kube-cluster-k3s-longhorn/)
- [longhorn 2](https://pongzt.com/post/kube-cluster-k3s-longhorn/)
- [longhorn 3](https://longhorn.io/docs/1.5.2/advanced-resources/deploy/customizing-default-settings/#using-the-longhorn-ui)