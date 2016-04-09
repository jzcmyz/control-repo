#!/bin/bash

if [ $(whoami) != 'root' ]; then
    echo "You really should be root while running $0"
    exit 1
fi

#
# Add --dry-run to test what will be downloaded
#

rsync --progress -av --delete --delete-excluded --exclude "SCL" --exclude "centosplus" --exclude "cloud" --exclude "contrib" --exclude "cr" --exclude "fasttrack" --exclude "isos" --exclude "sclo" --exclude "storage" --exclude "virt" --exclude "xen4" --exclude "i386" rsync://mirror.aarnet.edu.au/centos/6/ /srv/centos/6/

rsync --progress -av --no-o --no-g --delete --delete-excluded --exclude "atomic" --exclude "centosplus" --exclude "cloud" --exclude "cr" --exclude "fasttrack" --exclude "isos" --exclude "sclo" --exclude "storage" --exclude "virt" rsync://mirror.aarnet.edu.au/centos/7/ /srv/centos/7/


