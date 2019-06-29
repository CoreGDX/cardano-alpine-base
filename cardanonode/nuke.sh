#!/bin/sh

# Nukes all built docker images
docker rm -v cardanonode_jormungandr_1
docker rmi cardanonode_jormungandr:latest --force