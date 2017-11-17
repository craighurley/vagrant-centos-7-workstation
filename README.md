# vagrant-centos-7-workstation

Vagrant project for creating a CentOS-7 workstation.

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

        Default usr/pwd: `vagrant`/`vagrant`

        Optionally, start the graphical desktop

        ```
        $ startx
        ```

## Notes

### General

- selinux is enforcing.
- firewalld is enabled and by default only allows `ssh` and `dhcpv6-client`.
- clamav is installed and auto updates every 3 hours.

### cloud-init modules

As this project is using `vagrant`, it relies on the `nocloud` module.  There are two variations of this module; one that does not provide network access and one that does; this project uses the latter by default.

1. No network access: `/var/lib/cloud/seed/nocloud/`
1. Network access enabled: `/var/lib/cloud/seed/nocloud-net/`

## Links

- [https://www.centos.org/](https://www.centos.org/)
- [http://cloudinit.readthedocs.io](http://cloudinit.readthedocs.io)
