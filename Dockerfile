FROM php:8.1-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    libonig-dev \
    libpq-dev \
    libcurl4-openssl-dev \
    libxslt1-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        gd \
        intl \
        zip \
        mysqli \
        soap \
        xml \
        opcache \
        exif \
        xsl \
    && a2enmod rewrite

# Copy Moodle files
COPY . /var/www/html

# Moodle permissions
RUN chown -R www-data:www-data /var/www/html

# PHP config
COPY docker/php.ini /usr/local/etc/php/php.ini

# Apache config
COPY docker/apache.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/html

EXPOSE 80