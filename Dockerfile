FROM linuzilla/alpine-sshd:latest
MAINTAINER Mac Liu <linuzilla@gmail.com>

RUN apk update \
    && apk add nginx ca-certificates \
    php-fpm php-json php-zlib php-xml php-pdo php-phar php-openssl \
    php-pdo_mysql php-mysqli \
    php-gd php-iconv php-mcrypt 

ENV WWWROOT=public

# fix php-fpm "Error relocating /usr/bin/php-fpm: __flt_rounds: symbol not found" bug
RUN apk add -u musl
RUN rm -rf /var/cache/apk/* && rm -rf /tmp/src

ADD files/run.sh /run.sh
ADD files/nginx.conf /etc/nginx/
ADD files/php-fpm.conf /etc/php/
COPY files/supervisord.conf /etc/supervisord.conf
RUN chmod +x /run.sh

EXPOSE 22 80
VOLUME [ "/www", "/log" ]

CMD [ "/run.sh" ]
