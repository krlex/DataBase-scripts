#!/usr/bin/env bash

backup=$1 ; shift
[[ -z $backup ]] && echo "Usage: $0 <backup-name> [<dbname>...]" && exit 1

databases="$@"

rm -rf /host/$backup
mariabackup --user=root --backup \
    --databases="$databases" \
    --target-dir=/host/$backup

cd /host/
rm -f $backup.tgz
tar --create --gzip --file=$backup.tgz $backup

rm -rf $backup
