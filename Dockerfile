# Dockerfile for Render deployment of Laravel EcoGo API
# This container uses PHP and the built-in Laravel development server.
# For simple Render deployment, it listens on the PORT environment variable.

FROM php:8.2-cli-alpine

# System dependencies and PHP extensions required by Laravel
RUN apk add --no-cache \
        bash \
        curl \
        libzip-dev \
        zip \
        unzip \
        icu-dev \
        oniguruma-dev \
        sqlite-dev \
        $PHPIZE_DEPS \
    && docker-php-ext-install \
        pdo \
        pdo_sqlite \
        bcmath \
        ctype \
        fileinfo \
        intl \
        json \
        mbstring \
        opcache \
        xml \
        zip \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && apk del icu-dev oniguruma-dev libzip-dev $PHPIZE_DEPS

# Enable recommended PHP settings for Laravel
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

WORKDIR /var/www/html

# Copy only composer files first to leverage Docker cache
COPY composer.json composer.lock ./

# Install PHP dependencies
RUN composer install --prefer-dist --no-dev --no-scripts --no-progress --no-interaction

# Copy application source
COPY . ./

# Create storage directories and cache folders permissions
RUN mkdir -p storage/framework/cache/data storage/logs bootstrap/cache \
    && chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 8000

# Render sets $PORT automatically for web services.
CMD ["sh", "-c", "php artisan serve --host=0.0.0.0 --port=${PORT:-8000}"]
