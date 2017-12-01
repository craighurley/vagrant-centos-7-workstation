#!/usr/bin/env bash

set -ex

SUCCESS_INDICATOR=/opt/.vagrant_provision_workstation_success
FIREFOX="https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-GB"

# confirm this is a centos box
[[ ! -f /etc/centos-release ]] && exit 1

# check if provision script has run before
[[ -f $SUCCESS_INDICATOR ]] && exit 0

systemctl start firewalld
systemctl enable firewalld

yum install -y epel-release

yum install -y \
    clamav \
    clamav-update \
    git \
    glibc \
    gtk3 \
    libnm-gtk \
    libnma \
    pangox-compat \
    vim \
    wget \
    xterm \
    xulrunner

# remove default install of firefox if it exists
yum remove -y firefox
if [[ -f /usr/bin/firefox ]] ; then
    unlink /usr/bin/firefox
fi

# download and manually install a more recent version of firefox
wget --quiet -O firefox.tar.bz2 "$FIREFOX"
tar xfj firefox.tar.bz2 --directory /opt
ln -s /opt/firefox/firefox /usr/bin/firefox
rm firefox.tar.bz2

# hack: force firefox to create a _complete_ profile
su - vagrant -c 'firefox -screenshot http://checkip.amazonaws.com/'
rm /home/vagrant/screenshot.png

freshclam

# create file on provision success
touch $SUCCESS_INDICATOR

exit 0
