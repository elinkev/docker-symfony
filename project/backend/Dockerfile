FROM php:8.3-apache

# Changing DocumentRoot
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Composer requirements
RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get -y install zip
RUN apt-get -y install unzip
RUN apt-get -y install nano

# Symfiny cli recommendations
RUN apt-get install -y libicu-dev
RUN docker-php-ext-configure intl 

# DB Drivers
RUN docker-php-ext-install pdo pdo_mysql

# XDebug & opcache
RUN docker-php-ext-install intl opcache
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Copy php.ini
COPY ./config/php.ini /usr/local/etc/php/

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Enable this mod, otherwise routes wont work
RUN a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash && mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

# # Install NVM
# RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

# Copy files from docker root dir into container, then process them in the entrypoint script
COPY ./config/php-cs-fixer.dist ./app/.php-cs-fixer.dist.php
COPY ./tools/php-cs-fixer.sh /usr/local/bin/php-cs-fixer.sh
RUN chmod +x /usr/local/bin/php-cs-fixer.sh

# Adding entrypoint (https://stackoverflow.com/a/68665941)
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# WORKDIR /var/www/html
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]