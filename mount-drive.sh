#!/usr/bin/env bash

set -e
set -x

if [ -f /etc/provision_env_disk_added_date ]
then
   echo "Provision runtime already done."
   exit 0
fi


sudo fdisk -u /dev/sdb <<EOF
n
p
1


w
EOF

mkfs.ext4 /dev/sdb1
mount -t ext4 /dev/sdb1 /opt

echo "/dev/sdb1               /opt           ext4    defaults        1 2" >> /etc/fstab

date > /etc/provision_env_disk_added_date