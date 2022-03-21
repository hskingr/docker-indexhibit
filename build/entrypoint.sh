#!/bin/bash
echo Starting Entrypoint Script
cp -an /etc/apache2/sites-available-bak/. /etc/apache2/sites-available/
rm -R /etc/apache2/sites-available-bak
cp -an /var/www/html-bak/. /var/www/html/
rm -R /var/www/html-bak
# chmod 775 /var/www/html/ndxzsite/config/changeConfigVals.sh
# /var/www/html/ndxzsite/config/changeConfigVals.sh
# /usr/sbin/apache2ctl -D FOREGROUND
# service apache2 start
exec apache2-foreground
exec "$@"
echo Entrypoint End