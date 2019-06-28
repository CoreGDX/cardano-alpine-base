#!/bin/sh

# Nukes all built docker images
docker rm -v cardano-node_cardano-node_1
docker rmi cardano-node_cardano-node:latest --force