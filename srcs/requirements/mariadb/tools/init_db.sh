#!/bin/bash

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
mysqld_safe &
while ! mysqladmin ping --silent; do
    sleep 1
done
mysql -u root -p"${SQL_ROOT_PSW}" <<-EOF
CREATE DATABASE IF NOT EXISTS ${SQL_DB};
CREATE USER IF NOT EXISTS '${SQL_USR}'@'%' IDENTIFIED BY '${SQL_USR_PSW}';
GRANT ALL PRIVILEGES ON ${SQL_DB}.* TO '${SQL_USR}'@'%';
FLUSH PRIVILEGES;
EOF
mysqladmin -u root -p"${SQL_ROOT_PSW}" shutdown
exec mysqld_safe
