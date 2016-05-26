FROM linuzilla/alpine-sshd:latest
MAINTAINER Mac Liu <linuzilla@gmail.com>

COPY files/nginx.conf /etc/nginx/
COPY files/php-fpm.conf /etc/php/
COPY files/10php-fpm.sh /etc/init-scripts
COPY files/supervisord-nginx.conf /etc/supervisor.d/nginx.conf
COPY files/supervisord-phpfpm.conf /etc/supervisor.d/php-fpm.conf

RUN apk update \
    && apk add nginx ca-certificates \
    php-fpm php-json php-zlib php-xml php-pdo php-phar php-openssl \
    php-pdo_mysql php-mysqli php-mysql php-bcmath \
    php-gd php-iconv php-mcrypt; \
    apk add -u musl; \
    rm -rf /var/cache/apk/* && rm -rf /tmp/src; \
    chmod +x /etc/init-scripts/10php-fpm.sh

ENV WWWROOT=public
ENV FLAVOR=common
ENV WWWDATA_GROUPID=

EXPOSE 80
#VOLUME [ "/www", "/log" ]
