#!/bin/sh

# Nukes all built docker images
docker stop coregdx-jormungandr-alpine
docker rm -v coregdx-jormungandr-alpine
docker rmi coregdx/jormungandr:latest --force