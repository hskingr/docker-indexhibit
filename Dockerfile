FROM php:7.2-apache
RUN apt-get update && apt-get install -y && docker-php-ext-install mysqli && a2enmod rewrite && \
apt-get install nano zip unzip wget -y && mkdir /docker && mkdir /var/temp && \
mkdir /etc/apache2/sites-available-bak && cp -a /etc/apache2/sites-available/. /etc/apache2/sites-available-bak && \
wget -P /var/www https://github.com/Indexhibit/indexhibit/archive/refs/heads/master.zip && \
unzip /var/www/master.zip -d /var/www && cp -a /var/www/indexhibit-master/. /var/www/html/ && \
cd /var/www/html && chmod -R 777 /var/www/html/ && \
mkdir /var/www/html-bak && cp -a /var/www/html/. /var/www/html-bak

EXPOSE 80
EXPOSE 443
ENV SITE_NAME \
USER_NAME \
USER_LAST_NAME \
EMAIL \
DATABASE_SERVER_ADDRESS \
MARIADB_USER \
MARIADB_PASSWORD \
MARIADB_DATABASE

COPY ./build/entrypoint.sh /docker/entrypoint.sh
RUN chmod +x /docker/entrypoint.sh
COPY ./build/000-default.conf /etc/apache2/sites-available-bak/000-default.conf
COPY ./build/install.php /var/www/html-bak/ndxzstudio/install.php
ENTRYPOINT ["/docker/entrypoint.sh"]
RUN ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log
