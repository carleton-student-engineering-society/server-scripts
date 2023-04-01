#!/bin/bash
source constants.sh

FILE_COUNT=$(find $destdir -type f -mtime -0.9 -print | wc -l)
if (( $FILE_COUNT < 3 )); then
    echo "Backup failed, not all files are present in backup directory!" >&2
    exit 1
fi
