#!/usr/bin/env bash

if [ -z $1 ]; then
  echo "Enter the Dataname:"
  read DATANAME
else
  DATANAME=$1
fi

if [ -z $1 ]; then
  echo "Enter the Username:"
  read USERNAME
else
  USERNAME=$1
fi

stty -echo ; read -p "Enter New Password: " PASSWD; stty echo

green() {
  echo -e '\e[32m'$DATANAME'\e[m';
}

readonly E_BADARGS=65
readonly MYSQL=`which mysql`

# Construct the MySQL query
readonly Q1="CREATE DATABASE IF NOT EXISTS $DATANAME;"
readonly Q2="GRANT ALL ON *.* TO '$USERNAME'@'localhost' IDENTIFIED BY '$PASSWD';"
readonly Q3="FLUSH PRIVILEGES;"
readonly SQL="${Q1}${Q2}${Q3}"

# Run the actual command
$MYSQL -uroot -e "$SQL"

# If you want to activate with root password
# $MYSQL -uroot -p -e "$SQL"

# Let the user know the database was created
green "Database $DATANAME and user $USERNAME created with a password you chose"
