#!/bin/bash
echo Starting Entrypoint Script
ls -la /etc/apache2/sites-available
cp -an /etc/apache2/sites-available-bak/. /etc/apache2/sites-available/
rm -R /etc/apache2/sites-available-bak
cp -an /var/www/html-bak/. /var/www/html/
rm -R /var/www/html-bak


# /usr/sbin/apache2ctl -D FOREGROUND
# service apache2 start

# exec apache2-foreground
# exec "$@"
echo Entrypoint End