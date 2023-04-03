#!/bin/bash

export TAR_ARGS="--acls --xattrs --zstd -cpf"
export BACK_DEST="/opt/backup/"
export TAR_EXT=".tar.zst"

create_full(){
	archive_name="${BACK_DEST}${1}-$(hostname)-full${TAR_EXT}"
	backupdir=$2
	tar $TAR_ARGS $archive_name -T /dev/null $backupdir
}
create_incremental(){
	archive_name="${BACK_DEST}${1}-$(hostname)-inc${TAR_EXT}"
	backupdir=$2
	find $2 -type f -mtime -1 -print0 | xargs -0 tar $TAR_ARGS $archive_name -T /dev/null
}
# Determines what kind of backup to do. Full backups are every week and incremental backups nightly between them
# First argument should be the name of the archive
# Second argument should be the path to the folder/files to backup
create_backup(){
	day=`date '+%d'`
	if [ $day == 01 ] || [ $day == 8 ] || [ $day == 15 ] || [ $day == 22 ]; then
		create_full $@
	else
		create_incremental $@
	fi
}
