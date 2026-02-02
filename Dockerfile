FROM php:7.4-apache

# Install Moodle dependencies
RUN apt-get update && apt-get install -y libxml2 libcurl4-openssl-dev libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-install xml curl gd opcache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy Moodle source code into the container
COPY . /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose the Apache port
EXPOSE 80
