# Install and create db, user and set password

## Install MariaDB server

```
./mariadb-install.sh
```
## For basic config

```
./mariadb-create.sh database user password
```
## For backup

```
./mariadb-backup.sh
```

## For restore backup

```
./mariadb-restore.sh
```

## Install PostgresSQL server

```
./postgresql-install.sh
```

## For basic config

```
COMING SOON!!!
```
## For backup

```
./postgresql-backup.sh postgres mydatabase mydbschiema.sql mydbdata.sql --execlude-schema=audit
```
## For restore backup

```
./postgresql-restore.sh newsuser newdatabase mydbschiema.sql mydbdata.sql
```
## Install MongoDB server

```
./mongodb-install.sh
```

## For basic config

```
COMING SOON!!!
```

### This installation scripts work on:

```
- Debian
- Ubuntu
- Fedora
- CentOS
```
