FROM php:8.3.3-fpm

ENV COMPOSER_ALLOW_SUPERUSER = 1
RUN apt-get update \
    && apt-get upgrade \
    && apt-get install -y vim zip unzip libpq-dev zlib1g-dev libzip-dev libpng-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    openssh-server ssh \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer clear-cache \
    && useradd sshuser \
    && usermod -p $(openssl passwd -1 123456) -s /bin/bash -G sudo sshuser

COPY ./docker/ssh/sshd_config /etc/ssh/sshd_config
COPY ./docker/setup /var/www/html/setup
COPY ./ /var/www/html
#COPY .env.example /var/www/html/env

RUN composer install --prefer-source --no-interaction \
    && mkdir -p /var/run/sshd \
    && chmod -R 777 /var/www/html

EXPOSE 22
EXPOSE 80
EXPOSE 9000

CMD ["/var/www/html/setup/setup.sh"]
