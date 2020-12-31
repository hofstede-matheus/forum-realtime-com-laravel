FROM nginx:1.10-alpine

ADD vhost.conf /etc/nginx/conf.d/defaults.conf

COPY public /var/www/public
