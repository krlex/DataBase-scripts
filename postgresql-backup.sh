#!/usr/bin/env bash

if [ -z $1 ]; then
    echo "Enter the username:"
    read USERNAME
else
    USERNAME=$1
fi

if [ -z $2 ]; then
    echo "Enter the database name:"
    read DBNAME
else
    DBNAME=$2
fi

if [ -z $3 ]; then
    echo "Enter the schema file name:"
    read SCHEMA
else
    SCHEMA=$3
fi

if [ -z $4 ]; then
    echo "Enter the data file name:"
    read DATA
else
    DATA=$4
fi

if [ -z $5 ]; then
    echo "Extra params on data file:"
    read EXTRA
else
    EXTRA=$5
fi

pg_dump --username=$USERNAME --schema-only $DBNAME > $SCHEMA
pg_dump --username=$USERNAME --data-only --disable-triggers $EXTRA $DBNAME > $DATA
