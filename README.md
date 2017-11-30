# vagrant-centos-workstation

Vagrant project for creating a CentOS workstation.

## Requirements

Vagrant plugins:

- vagrant-vbguest

## How to Use

1. Start the box

    ```sh
    $ vagrant up
    ```

1. Login via SSH or RDP

    1. SSH

        ```sh
        $ vagrant ssh
        ```

        ... or if you want to use the box as a SOCKS proxy:

        ```
        $ vagrant ssh -- -D 127.0.0.1:8080
        ```

    1. RDP

        Login via virtualboxes remote display by RDP'ing to `localhost:3389`.

        Optionally, start the graphical desktop if it has been installed:

        ```
        $ startx
        ```

## Notes

### Usr/pwd

- `vagrant`/`vagrant`

### General

- selinux is enforcing.
- firewalld is enabled and by default only allows `ssh` and `dhcpv6-client`.
- clamav is installed and auto updates every 3 hours.

### Graphical Desktop

If you want to install the graphical desktop:

```
yum group install -y "GNOME Desktop"
```

To start the graphical desktop at boot:

```
unlink /etc/systemd/system/default.target
ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
```

### cloud-init modules

As this project is using `vagrant`, it relies on the `nocloud` module.  There are two variations of this module; one that does not provide network access and one that does; this project uses the latter by default.

1. No network access: `/var/lib/cloud/seed/nocloud/`
1. Network access enabled: `/var/lib/cloud/seed/nocloud-net/`

## Links

- [https://www.centos.org/](https://www.centos.org/)
- [http://cloudinit.readthedocs.io](http://cloudinit.readthedocs.io)
