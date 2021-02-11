#!/usr/bin/env bash

green() {
  echo -e '\e[32m'$1'\e[m';
}

readonly EXPECTED_ARGS=3
readonly E_BADARGS=65
readonly MYSQL=`which mysql`

# Construct the MySQL query
readonly Q1="CREATE DATABASE IF NOT EXISTS $1;"
readonly Q2="GRANT ALL ON *.* TO '$2'@'localhost' IDENTIFIED BY '$3';"
readonly Q3="FLUSH PRIVILEGES;"
readonly SQL="${Q1}${Q2}${Q3}"

# Do some parameter checking and bail if bad
if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: $0 dbname dbuser dbpass"
  exit $E_BADARGS
fi

# Run the actual command
$MYSQL -uroot -e "$SQL"

# If you want to activate with root password
# $MYSQL -uroot -p -e "$SQL"

# Let the user know the database was created
green "Database $1 and user $2 created with a password you chose"
