FROM shakyshane/laravel-php:latest

WORKDIR /var/www

COPY composer.json /var/www

COPY database /var/www/database

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
&& php composer-setup.php \
&& php -r "unlink('composer-setup.php');" \
&& php composer.phar install --no-scripts \
&& rm composer.phar

COPY . /var/www

RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

RUN ls
RUN php artisan key:generate
RUN php artisan config:cache
RUN php artisan optimize