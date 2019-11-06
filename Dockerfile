FROM php:7.4-rc-fpm-alpine

LABEL Organization="CTFTraining" Author="Virink <virink@outlook.com>"

COPY _files /tmp/

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk add --update --no-cache nginx \
    && mkdir /run/nginx \
    # configure file
    && mv /tmp/flag.sh /flag.sh \
    && mv /tmp/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint \
    && mv /tmp/nginx.conf /etc/nginx/nginx.conf \
    && chown -R www-data:www-data /var/www/html \
    && chmod +x /usr/local/bin/docker-php-entrypoint \
    && echo '<?php phpinfo();' > /var/www/html/index.php \
    # clear
    && rm -rf /tmp/*
    # && rm -rf /etc/apk

WORKDIR /var/www/html

EXPOSE 80

VOLUME ["/var/log/nginx"]

CMD ["/bin/bash", "-c", "docker-php-entrypoint"]