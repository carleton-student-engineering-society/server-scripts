#!/bin/bash
# This file backs up the contents of the mariadb databases on this server to a file

source create_tarball.sh

cd /

type=db
date=$(date "+%F")
backupfile="$type-$date"

sql=tmp/db.sql

umask 077
mysqldump --all-databases > $sql
create_backup $backupfile $sql
rm $sql
