FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    COMPOSER_ALLOW_SUPERUSER=1 \
    PHP_VERSION=8.2

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    curl \
    git \
    unzip \
    nginx \
    supervisor \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-common \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-bcmath \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-readline \
    php${PHP_VERSION}-sqlite3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Setup document root
RUN sed -i "s|listen = /run/php/php${PHP_VERSION}-fpm.sock|listen = 127.0.0.1:9000|" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
RUN sed -i "s|;cgi.fix_pathinfo=1|cgi.fix_pathinfo=0|" /etc/php/${PHP_VERSION}/fpm/php.ini

# Configure Nginx
COPY ./.docker/nginx.conf /etc/nginx/sites-available/default

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Install Node dependencies and build assets
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install \
    && npm run build

# Generate application key
RUN php artisan key:generate

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port
EXPOSE 8000

# Start services
CMD ["./.docker/start-container"]