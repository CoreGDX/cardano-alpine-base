#!/bin/sh

# Nukes all built docker images
docker rm -v cardano-node_jormungandr_1
docker rmi cardano-node_jormungandr:latest --force