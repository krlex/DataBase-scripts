#!/bin/bash

# Load variables from .env file
if [ -f .env ]; then
  export $(cat .env | grep -v '^#' | xargs)
fi

# Backup directory
BACKUP_DIR="$BACKUP_PATH"

# Remote server details
REMOTE_SERVER="$REMOTE_SERVER_ADDRESS"
REMOTE_USER="$REMOTE_SERVER_USER"
REMOTE_DIR="$REMOTE_PATH"

# Create a timestamp for the backup file
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# Backup MySQL database
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/mysql_backup_$TIMESTAMP.sql

# Transfer backup to remote server
scp $BACKUP_DIR/mysql_backup_$TIMESTAMP.sql $REMOTE_USER@$REMOTE_SERVER:$REMOTE_DIR

echo "MySQL backup and transfer completed: $BACKUP_DIR/mysql_backup_$TIMESTAMP.sql"
