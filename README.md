# vagrant-centos-7-workstation

Vagrant project for creating a CentOS-7 workstation.

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

    1. RDP

        Login via virtualboxes remote display by RDP'ing to `localhost:3389`.

        Default usr/pwd: `vagrant`/`vagrant`

        Optionally, start the graphical desktop

        ```
        $ startx
        ```

## Notes

### Modules

As this project is using `vagrant`, it relies on the `nocloud` module.  There are two variations of this module; one that does not provide network access and one that does; this project uses the latter by default.

1. No network access: `/var/lib/cloud/seed/nocloud/`
1. Network access enabled: `/var/lib/cloud/seed/nocloud-net/`

## Links

[http://cloudinit.readthedocs.io](http://cloudinit.readthedocs.io)
