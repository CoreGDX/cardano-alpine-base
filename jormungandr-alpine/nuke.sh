#!/bin/sh

# Nukes all built docker images
docker rm -v coregdx/jormungandr:latest
docker rmi coregdx/jormungandr:latest --force