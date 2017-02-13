FROM php:7.0-apache
#RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
#RUN chmod a+x /usr/local/bin/symfony
RUN docker-php-ext-install mbstring
RUN a2enmod rewrite
RUN rm -rf /var/www/html/sym_test
ADD ./ /var/www/html/sym_test
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer
WORKDIR /var/www/html/sym_test/
RUN apt-get update && apt-get install zip unzip && composer install -o --no-interaction
RUN chmod -R 0777 /var/www/html/sym_test
#RUN php bin/console cache:clear --env=prod
#COPY app/php.ini /usr/local/etc/php
#WORKDIR /var/www/html/sym_test/web
#EXPOSE 8000
#CMD php bin/console server:run 0.0.0.0:8000
