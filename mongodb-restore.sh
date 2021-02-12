#!/usr/bin/env bash

DB_BACKUP_PATH='$1'
DB_BACKUP_NAME='$2'

mongorestore --gzip --archive=${DB_BACKUP_PATH}/${DB_BACKUP_NAME}.gz
