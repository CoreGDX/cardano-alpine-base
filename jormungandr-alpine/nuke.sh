#!/bin/sh

# Nukes all built docker images
docker rm -v jormungandr-alpine_jormungandr-alpine_1
docker rmi jormungandr-alpine_jormungandr-alpine:latest --force