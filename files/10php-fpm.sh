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

if [ -f /etc/settings.d/${FLAVOR}/php.ini ]; then
	cp -f /etc/settings.d/${FLAVOR}/php.ini /etc/php/php.ini
	chmod 644 /etc/php/php.ini
fi

# start nginx
#mkdir -p /www/logs/nginx
mkdir -p /tmp/nginx
chown nginx /tmp/nginx

# php-fpm
