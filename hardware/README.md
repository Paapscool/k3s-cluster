# HARDWARE

From my exploration for the infrastructure, i would to have a script to install and configure a new server fastly with a common and robust configuration.

I don't know if it's the best way to do it, but it's a good start for me to have the possibility to setup new nodes for my cluster on demand.

Script are executed from debian version and i can't guarantee that it will work on other linux distribution.

Feel free to contribute to improve the project to fix issues, add new features or improve the security.

## Pre-requisites

To run scripts, you need to have a rescue session base on `linux`, available on your vps or your local machine. For the local machine, you can create a [rescue usb key to boot on it](../rescue_key/README.md).

Additionnaly, you need to have a ssh key pair to setup the ssh connection with the new installed server. If you don't have one, you can create it with the following command:

```bash
<$ ssh-keygen -t ed25519 -C "<your-email>"
```

/!\ If the ssh domain is already record in your known_hosts file, you need to remove it before generate a new one.

```bash
ssh-keygen -R "<your-private-key-name>"
rm $HOME/.ssh/<your-private-key-name>
rm $HOME/.ssh/<your-private-key-name>.pub
```

Too, you need to have:

- a domain name and a DNS server to manage your domain name
- configure the config_<your-target>.sh file
- verify the network configuration inside the `resources/nftables` and `resources/fail2ban` folders
- save previous data on your server (if you want to keep them)

### Minimal configuration

From my tests, the minimal configuration for your server is:

- 2 vCore
- 4 Go memory ram
- 40 Go disk storage

:warning: postgresql usage could increase the memory ram and cpu usage and could cause limitations with this configuration.

:warning: from my tests, the k3s usage seems to have need 24 Go disk storage (without persistent data).

## What does the script inside

The scripts format disk, install and configure a new debian system on your remote server.

Details installation:

- Format and partition disk
- Install debian system
- Install needed packages for use the k3s scripts
- Create and configure new user
- Configure and secure ssh connection
- Configure and secure network
- Install and configure firewall
- Install and configure fail2ban

After the installation, if an error occurs, you can connect to your server with the rescue session and mount / unmount the system with the utils scripts inside the `/` folder.

## Install

For run the installation, go to the hardware folder and run the following command:

``` bash
<$ \
  TARGET_NAME='<vps|local>' \
  RESCUE_SSH_HOST='<your-rescue-ssh-host>' \
  RESCUE_SSH_USER='<your-rescue-ssh-user>' \
  SERVER_SSH_PUBLIC_KEY_PATH='your-ssh-key-path' \
  make install
```

or

``` bash
make install
# prompt should ask you the needed informations
```

In the twices cases, you need to ask to the prompt to provide the user password for the new installed server.

After installation, you can connect to your server with the new user and the ssh key, Enjoy! :sunglasses:

## Complementary informations

After the installation, you can tests openned ports with the following command:

``` bash
nmap -Pn <your-server-ip>
```

### Issues

During the installations process, you can have some issues. At this time, i don't have solve them, but it seems to be not blocking for the installation process.

- Any logs return debconf warnings (ex: debconf: unable to initialize frontend: Dialog) [Study point to solve](https://superuser.com/questions/1470562/debian-10-over-ssh-ignoring-debian-frontend-noninteractive)

## Source guide

Many documentations help me to create this project. I try to list the most important here:

[script-partitionning](https://superuser.com/questions/332252/how-to-create-and-format-a-partition-using-a-bash-script)
[fstab](https://debian-facile.org/doc:systeme:fstab)
