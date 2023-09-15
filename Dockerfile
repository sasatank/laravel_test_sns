# ベースイメージを指定
FROM ubuntu:20.04

# 必要なパッケージをインストール
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    supervisor \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# PHPをインストール
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    php-cli \
    php-fpm \
    php-zip \
    php-gd \
    php-mbstring \
    php-xml \
    php-curl \
    php-mysql \
    php-json \
    php-tokenizer \
    php-bcmath \
    php-xmlrpc \
    php-opcache \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Composerをインストール
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Laravel Sailのディレクトリに移動
WORKDIR /var/www/html/vendor/laravel/sail

# コンテナ内での環境変数設定
ENV WWWUSER=www-data
ENV WWWGROUP=www-data

# Composerの依存関係をインストール
RUN composer install --no-interaction --no-plugins --no-scripts

# Laravel Sailを起動
CMD php /var/www/html/vendor/laravel/sail/runtimes/8.2/start