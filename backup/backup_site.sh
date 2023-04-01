#!/bin/bash

# Back up network shares

source create_tarball.sh

cd /

type=web
date=$(date "+%F")
backupfile="$type-$date"

backupdir=/var/www/

create_backup $backupfile $backupdir
