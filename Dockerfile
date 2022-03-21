FROM php:7.2-apache
RUN apt-get update && apt-get install -y && docker-php-ext-install mysqli && a2enmod rewrite
RUN apt-get install nano zip unzip wget -y
RUN mkdir /docker && mkdir /var/temp
COPY ./build/entrypoint.sh /docker/entrypoint.sh
RUN ["chmod", "+x", "/docker/entrypoint.sh"]
RUN mkdir /etc/apache2/sites-available-bak && cp -a /etc/apache2/sites-available/. /etc/apache2/sites-available-bak
RUN wget -P /var/www https://github.com/Indexhibit/indexhibit/archive/refs/heads/master.zip
RUN unzip /var/www/master.zip -d /var/www && cp -a /var/www/indexhibit-master/. /var/www/html/ && \
cd /var/www/html && chmod -R 777 /var/www/html/
RUN mkdir /var/www/html-bak && cp -a /var/www/html/. /var/www/html-bak
EXPOSE 80
ENV SITE_NAME \
USER_NAME \
USER_LAST_NAME \
EMAIL \
DATABASE_SERVER_ADDRESS \
MARIADB_USER \
MARIADB_PASSWORD \
MARIADB_DATABASE

COPY ./build/000-default.conf /etc/apache2/sites-available-bak/000-default.conf
COPY ./build/install.php /var/www/html-bak/ndxzstudio/install.php
# COPY ./dev/changeConfigVals.sh /var/www/html/ndxzsite/config
ENTRYPOINT ["/docker/entrypoint.sh"]
RUN ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log
