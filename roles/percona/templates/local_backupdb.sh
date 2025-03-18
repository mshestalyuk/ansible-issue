#!/bin/bash

DATE=$(date +"%d-%m-%Y_%H-%M")

BACKUP_DIR="/root/mysql_dump/$DATE"
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump

mkdir -p "$BACKUP_DIR/"

databases=`$MYSQL --host=localhost --user=root --password={{ mysql_root_password }} --user=root -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

for db in $databases; do
  $MYSQLDUMP --opt --no-create-db --user=root --password={{ mysql_root_password }}  $db | gzip -1 > "$BACKUP_DIR/$TIME/$db.sql.gz"
done

clear_old='find /root/mysql_dump/ -type d -ctime +15 -exec rm -rf {} \;'
#copy last\fresh baskcups to remote the b2-server
rclone sync /root/mysql_dump/ backblaze:pirogi/database_backups/
