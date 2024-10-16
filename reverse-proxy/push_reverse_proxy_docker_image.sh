#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Treat unset variables as an error
set -u

# build reverse proxy image
./build_reverse_proxy_docker_image.sh

# Docker login
docker login

# fetch user name from docker login
export DOCKER_USERNAME=$(docker info | grep Username | awk '{print $2}')

# tag reverse proxy image
docker tag tq-reverse-proxy:latest  $DOCKER_USERNAME/tq-reverse-proxy:latest

# push reverse proxy image to docker hub
docker push $DOCKER_USERNAME/tq-reverse-proxy:latest
