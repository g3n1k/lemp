# original from
# https://medium.com/@faidfadjri/how-to-setup-laravel-nginx-using-docker-2023-ba9de4b60d04

# use PHP 8.2
FROM php:8.2-fpm

# Install common php extension dependencies
RUN apt-get update && apt-get install -y \
    libfreetype-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    zlib1g-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip


###########################################################################
# Mysqli:
###########################################################################

ARG INSTALL_MYSQLI=false

RUN if [ ${INSTALL_MYSQLI} = true ]; then \
    docker-php-ext-install mysqli \
    ;fi

###########################################################################
# bcmath:
###########################################################################

ARG INSTALL_BCMATH=false

RUN if [ ${INSTALL_BCMATH} = true ]; then \
    docker-php-ext-install bcmath \
    ;fi




# Set the working directory
# COPY . /var/www/app
WORKDIR /var/www

RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www


# install composer
COPY --from=composer:2.6.5 /usr/bin/composer /usr/local/bin/composer

COPY dev.ini /usr/local/etc/php/conf.d/

# copy composer.json to workdir & install dependencies
# COPY composer.json ./
# RUN composer install

# Set the default command to run php-fpm
CMD ["php-fpm"]