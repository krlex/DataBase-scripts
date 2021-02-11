#!/bin/bash -x

file=$1
backup=${file%%.tgz}
backup=$(basename $backup)

cd /host/
tar --extract --gunzip --file $backup.tgz
mariabackup --user=root --prepare --target-dir=$backup

cd $backup
for dir in $(ls -d */); do
    dbname=${dir%/}
    mysql -e "drop database $dbname";
done
cd ..

# If you need more help go to see: https://mariadb.com/kb/en/library/full-backup-and-restore-with-mariadb-backup/#restoring-with-other-tools
systemctl stop mariadb.service

rsync -avrP $backup/ /var/lib/mysql/
rm -f /var/lib/mysql/ib_logfile*

chown -R mysql:mysql /var/lib/mysql/
chmod g+rw -R /var/lib/mysql/

systemctl start mariadb.service

rm -rf $backup
rm -f $backup.tgz
