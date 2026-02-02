FROM php:7.4-apache-buster

# Install Moodle dependencies along with build tools for PHP extensions
RUN apt-get update --fix-missing && apt-get install -y \
    libxml2 libcurl4-openssl-dev libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev \
    gcc make autoconf libc-dev pkg-config \
    && docker-php-ext-install xml curl gd opcache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy Moodle source code into the container
COPY . /var/www/html

# Set permissions for Moodle files
RUN chown -R www-data:www-data /var/www/html

# Expose Apache port
EXPOSE 80