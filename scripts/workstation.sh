#!/usr/bin/env bash

set -ex

systemctl start firewalld
systemctl enable firewalld

yum group install -y "GNOME Desktop"

# enable graphical display at boot (commented out by default to save resources -- use startx when a GUI is needed)
#unlink /etc/systemd/system/default.target
#ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target

yum install -y epel-release

yum install -y vim \
    tmux \
    tree \
    clamav \
    clamav-update \
    pangox-compat \
    openconnect \
    NetworkManager-openconnect-gnome

freshclam

exit 0
