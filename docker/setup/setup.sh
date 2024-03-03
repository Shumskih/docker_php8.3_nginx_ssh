#!/bin/bash

# start php-fpm
/var/www/html/setup/fpm.sh &

# for laravel
#php artisan key:generate &
#php artisan migrate --seed &
#php artisan config:cache &
#php artisan route:cache &

# start ssh
/var/www/html/setup/sshd.sh
