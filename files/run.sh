#!/bin/sh

DOCROOT=/www
[ "${WWWROOT}" = "" ] || DOCROOT=/www/${WWWROOT}

if [ ! -d ${DOCROOT} ] ; then
	mkdir -p ${DOCROOT}
	chgrp www-data ${DOCROOT}
	chgrp 2770 ${DOCROOT}
fi

sed -i "s,__DOCROOT__,${DOCROOT}," /etc/nginx/nginx.conf
sed -i "s,__DOCROOT__,${DOCROOT}," /etc/php/php-fpm.conf

# start php-fpm
#mkdir -p /www/logs/php-fpm
php-fpm

# start nginx
#mkdir -p /www/logs/nginx
mkdir -p /tmp/nginx
chown nginx /tmp/nginx

sleep 1

supervisord --nodaemon --configuration /etc/supervisord.conf
