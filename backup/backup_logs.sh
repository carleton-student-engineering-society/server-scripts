#!/bin/bash

# Back up logs

source create_tarball.sh

cd /

type=logs
date=$(date "+%F")
backupfile="$type-$date"

backupdir=var/log

create_backup $backupfile $backupdir
