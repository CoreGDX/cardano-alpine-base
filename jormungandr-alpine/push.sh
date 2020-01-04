#!/bin/sh

# This script will push the latest built version of
# the alpine-jormungandr image into a remote docker repository
# usage is as follows
# sh push.sh [VERSION]
# example
# sh push.sh 0.8.5-rc1
echo "pushing: coregdx/jormungandr:release-$1"
docker tag jormungandr-alpine_jormungandr-alpine:latest coregdx/jormungandr:release-$1
docker push coregdx/jormungandr:release-$1