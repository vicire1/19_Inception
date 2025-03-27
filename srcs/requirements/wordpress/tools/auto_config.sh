#!/bin/bash

sleep 10

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

cd /var/www/html
# rm -rf /var/www/html/*
if [ ! -s "wp-config.php" ]
then

	echo "Downloading WordPress..."
	wp core download --allow-root

	echo "Creating wp-config.php..."
	wp config create --allow-root --dbname=$SQL_DB --dbuser=$SQL_USR --dbpass=$SQL_USR_PSW --dbhost=$DB_HOST --skip-check

	echo "Installing WordPress..."
	wp core install --allow-root --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PSW --admin_email=$WP_ADMIN_MAIL

	echo "Creating new user..."
	wp user create "$WP_USER" "$WP_USER_MAIL" --role=subscriber --user_pass="$WP_USER_PSW" --allow-root --path=/var/www/html

else
	echo "Wordpress already installed."
fi

exec /usr/sbin/php-fpm7.4 -F
