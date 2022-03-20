#!/bin/bash

DEPLOYMENT_SRC=/tmp/deploy-$DEPLOYMENT_GROUP_ID-$DEPLOYMENT_ID
DEPLOYMENT_DST=/usr/share/nginx/html/app/payment-gateway
DEPLOYMENT_TMP=`mktemp -d`

echo "Fixing permissions"
sudo chown -R nginx:nginx $DEPLOYMENT_SRC
find $DEPLOYMENT_SRC -type d -exec chmod 770 {} \;
find $DEPLOYMENT_SRC -type f -exec chmod 660 {} \;

# if [ ! -f $DEPLOYMENT_SRC/composer.json ] || [ -f $DEPLOYMENT_SRC/composer.phar ];
# then
#         echo "Cant find vandor"
#         exit 1
# fi

echo "Move folder into place"
mv $DEPLOYMENT_DST $DEPLOYMENT_TMP && mv $DEPLOYMENT_SRC $DEPLOYMENT_DST && rm -rf $DEPLOYMENT_TMP

# sudo php artisan optimize:clear
# sudo php artisan optimize
# sudo composer dump-autoload -o
sudo systemctl restart nginx php-fpm
sudo supervisorctl restart all