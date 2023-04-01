#!/bin/bash
# Backs up all important data on this server

umask 027

source constants.sh

echo -n "Backup Sites: " && ./backup_site.sh && echo "Done"
echo -n "Backup DB: " && ./backup_db.sh && echo "Done"
echo -n "Backup Logs: " && ./backup_logs.sh && echo "Done"

chown -R root:backup $destdir
chmod -R 750 $destdir

for file in $destdir/*; do
	if [[ $(find "$file" -mtime +30 -print) ]]; then
		echo "File $file exists and is older than 180 days, pruning"
		rm -f $file
	fi
done
./backup_verify.sh

