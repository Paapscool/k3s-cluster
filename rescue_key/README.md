# Rescue USB

The global motivation is to have an usb rescue key for install or maintain debian version on my local environment. I would to have a ssh access from my working station. My server do not have monitor, keyboard etc..., so i would operate any things from my working stations without change my cable management.

/!\ WARNING : Keep in mind, this steps work fine from debian 11 installation, probably, depends on your support, you could to have any issue about the syntax or anythings ...

:warning: the following guide and scripts are a little old but could work fine. Maybe I will update it but i don't know when ...

Don't hesitate to contribute to improve the project to fix issues, add new features or improve the security.

## Install

For create a live usb rescue key, we need to create a debian live usb with ssh for maintain or reset your local server(s) installation.
From an other debian machine i run a automated installation on my USB flash drive of 16Go to have a USB rescue mode flash drive.

### Initial state

Before run the script, configure your user for be root and give the group `sudo` inside the system. Then update the sudoers file to permit execute sudo command without ask password.

``` bash
sudo visudo /etc/sudoers
```

add this line at the end of the file:

``` bash
<user_name>   ALL=(All) NOPASSWD:ALL
```

> :warning: it is a BIG SECURITY point, don't forget to remove this line after script execution for save and exit from nano, ctrl+O, enter and ctrl+X

### Run installation

Finally, run the scripts with the makefile:

``` bash
# from the rescue_usb folder
# Rescue is the debian server with the rescue key plugged
# SERVER_* is the data of your future rescue key
<$ \
        RESCUE_SSH_HOST='<debian_ssh_host>' \
        RESCUE_SSH_USER='<debian_ssh_user>' \
        SERVER_DOMAIN_NAME='<rescue_domain_name>' \
        SERVER_DOMAIN_EXTENSION='<rescue_domain_extension>' \
        SERVER_USER_PASSWORD='<rescue_root_password>' \
        make
```

> :warning: Remove the new line added inside /etc/sudoers

### Validation

From now, the installation should reboot automaticly on your rescue USB key:

``` bash
<$ ssh root@<your-ip-server>
# testing installation
root@<your-ip-server>'s password:
<your-desired-password-for-usbrescue-root>
```

## Usage

After your usb rescue key was created, you should to have two situation for boot on your rescue session. In fact, if you disconnect your usb key from the machine, the `UEFI bios configuration` will forgot the boot entry. So you could not define a priority on the USB Key.
[Discussion about this issue](https://superuser.com/questions/1055189/getting-uefi-bios-boot-order-consistency-when-attaching-removing-usb)

If you let the usb key connected to the system to keep the entry boot recorded, you will expose a vulnerability access to the rescue method from a potential hacker.

So let check how boot on your rescue usb key in these two cases

### Local server boot failure

When your local server cannot boot, you just need plug your rescue key to have a success boot on it. Because, the usb boot is the only one that is functionnal, the machine will automatically boot as expected.

### Local server boot success

When your local server boot properly, the bootloader should start ever on the local boot system. In this case, you should to connect you on your system to run the following commands to restart on the rescue key.

``` bash
# Get the boot number associated to the rescue key
RESCUEKEY_NB=$(sudo efibootmgr | grep -w 'USB DISK' | sed -e 's/Boot//g' | sed -e 's/\*.*USB DISK.*//g')
# Configure the next reboot on the rescue key and reboot
sudo efibootmgr --bootnext $RESCUEKEY_NB && sudo systemctl reboot
```

Enjoy !

## Issues

Several warnings appear during the installation but do not seem to cause any malfunction:

> perl: warning: Falling back to the standard locale ("C"). locale: Cannot set LC_CTYPE to default locale: No such file or directory ...
> debconf: unable to initialize frontend: Dialog ...
> W: Possible missing firmware /lib/firmware/rtl_nic/rtl8125b-2.fw for module r8169 ...

Any solutions was tested without succes.
