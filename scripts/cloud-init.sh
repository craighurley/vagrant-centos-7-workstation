#!/usr/bin/env bash

set -ex

SUCCESS_INDICATOR=/opt/.vagrant_provision_success
# SUCCESS_INDICATOR=/opt/.vagrant_provision_cloud_init_success
DATA_SOURCE=/var/lib/cloud/seed/nocloud-net
META_DATA=/tmp/cloud-init/meta-data
USER_DATA=/tmp/cloud-init/user-data

# confirm this is a centos box
[[ ! -f /etc/centos-release ]] && exit 1

# check if provision script has run before
[[ -f $SUCCESS_INDICATOR ]] && exit 0

# install cloud-init
yum install -y cloud-init

# write cloud-init files
mkdir -p $DATA_SOURCE
[[ -f $META_DATA ]] && cp $META_DATA $DATA_SOURCE/ || exit 1
[[ -f $USER_DATA ]] && cp $USER_DATA $DATA_SOURCE/ || exit 1

# force cloud-init to run
cloud-init init
cloud-init modules

# create file on provision success
touch $SUCCESS_INDICATOR

exit 0
