#!/bin/bash

DEPLOYMENT_SRC=/opt/codedeploy-agent/deployment-root/$DEPLOYMENT_GROUP_ID/$DEPLOYMENT_ID/deployment-archive
DEPLOYMENT_DST=/tmp/deploy-$DEPLOYMENT_GROUP_ID-$DEPLOYMENT_ID
mkdir $DEPLOYMENT_DST
cp -r /usr/share/nginx/html/app/payment-gateway-back/* $DEPLOYMENT_DST
echo "Copy to tmp deployment folder"
rsync -r $DEPLOYMENT_SRC/ $DEPLOYMENT_DST/

cd $DEPLOYMENT_DST

echo "Install composer"
/bin/sh $DEPLOYMENT_DST/install_composer.sh

echo "Run composer install"
./composer.phar i --no-interaction --prefer-dist --optimize-autoloader

#echo "Remove composer.phar"
#rm -f composer.phar
