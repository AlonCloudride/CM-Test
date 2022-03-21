#!/bin/bash

DEPLOYMENT_SRC=/tmp/deploy-$DEPLOYMENT_GROUP_ID-$DEPLOYMENT_ID
DEPLOYMENT_DST=/usr/share/nginx/html/app/payment-gateway
DEPLOYMENT_TMP=`mktemp -d`

cp composer.phar /usr/bin/composer

echo "Fixing permissions"
sudo chown -R nginx:nginx $DEPLOYMENT_SRC
find $DEPLOYMENT_SRC -type d -exec chmod 770 {} \;
find $DEPLOYMENT_SRC -type f -exec chmod 660 {} \;

#echo "Checking for composer"
#if [ ! -f $DEPLOYMENT_SRC/composer.json ] || [ -f $DEPLOYMENT_SRC/composer.phar ];
#then
#         echo "Cant find vandor"
#         exit 1
#fi
aws s3 cp s3://pm-gateway-prod-bucket/.env.production .env
echo "Move folder into place"
mv $DEPLOYMENT_DST $DEPLOYMENT_TMP && mv $DEPLOYMENT_SRC $DEPLOYMENT_DST && rm -rf $DEPLOYMENT_TMP

echo "Moving to deployment folder"
cd $DEPLOYMENT_DST
ls -la && pwd

echo "Artisan"
php artisan optimize:clear
php artisan optimize

echo "Composer"
composer dump-autoload -o

echo "Restarts"
sudo systemctl restart nginx php-fpm

sudo supervisorctl restart all
