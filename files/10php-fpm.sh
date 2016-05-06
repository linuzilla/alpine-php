#!/bin/sh

DOCROOT=/www
[ "${WWWROOT}" = "" ] || DOCROOT=/www/${WWWROOT}

if [ "${WWWDATA_GROUPID}" != "" ]; then
	sed -i "s/^www-data:x:[0-9]*:/www-data:x:${WWWDATA_GROUPID}:/" /etc/group
	chgrp www-data /www
	chmod g+sx,o-rwx /www
fi

if [ -f /etc/settings.d/${FLAVOR}/php.ini ]; then
	cp -f /etc/settings.d/${FLAVOR}/php.ini /etc/php/php.ini
	chmod 644 /etc/php/php.ini
fi

if [ -d /etc/settings.d/${FLAVOR}/conf.d ]; then
	if [ -f /etc/settings.d/${FLAVOR}/nginx.conf ]; then
		cp -f /etc/settings.d/${FLAVOR}/nginx.conf /etc/nginx/
	fi
	cp -f /etc/settings.d/${FLAVOR}/conf.d/* /etc/nginx/conf.d/
fi

sed -i "s,__DOCROOT__,${DOCROOT}," /etc/nginx/nginx.conf
sed -i "s,__DOCROOT__,${DOCROOT}," /etc/php/php-fpm.conf

# start nginx
#mkdir -p /www/logs/nginx
mkdir -p /tmp/nginx
chown nginx /tmp/nginx

# php-fpm
