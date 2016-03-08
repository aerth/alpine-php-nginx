FROM alpine:3.2

MAINTAINER aerth@sdf.org

EXPOSE 80

RUN apk add --update ca-certificates nginx \
  php-fpm php-json php-zlib php-xml php-intl php-pdo php-phar php-openssl \
  php-pdo_mysql php-mysqli php-gd php-iconv php-mcrypt php-dom php-ctype \
  php-opcache php-curl bash git php-sqlite3 php-pdo php-pdo_sqlite

COPY files/build_extensions.sh /
COPY files/run.sh /

RUN chmod +x /run.sh && \
    chmod +x /build_extensions.sh && \
    mkdir -p /var/log/nginx && \
    mkdir -p /var/log/php-fpm

RUN /build_extensions.sh

RUN rm /build_extensions.sh

COPY files/nginx.conf /etc/nginx/
COPY files/php-fpm.conf /etc/php/
RUN mkdir -p /var/www/public && \
	chown -R nginx:nginx /var/www/ && \
	echo "<?php echo \"Hello, World.\"; ?>">>/var/www/public/index.php
CMD ["/run.sh"]
