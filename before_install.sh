#!/bin/bash

DEPLOYMENT_SRC=/opt/codedeploy-agent/deployment-root/$DEPLOYMENT_GROUP_ID/$DEPLOYMENT_ID/deployment-archive
DEPLOYMENT_DST=/tmp/deploy-$DEPLOYMENT_GROUP_ID-$DEPLOYMENT_ID

mkdir $DEPLOYMENT_DST

echo "Copy to tmp deployment folder"
rsync -r $DEPLOYMENT_SRC/ $DEPLOYMENT_DST
