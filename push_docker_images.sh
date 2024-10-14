#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Treat unset variables as an error
set -u

# Docker login
if [ -z "${DOCKER_USERNAME:-}" ] || [ -z "${DOCKER_PASSWORD:-}" ]; then
  echo "DOCKER_USERNAME and DOCKER_PASSWORD must be set"
  exit 1
fi
echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin

# call ./build_docker_images.sh to build all images
./build_docker_images.sh

# push all above to docker hub
docker tag tq-backend:latest  $DOCKER_USERNAME/tq-backend:latest
docker push $DOCKER_USERNAME/tq-backend:latest

docker tag tq-frontend-desktop:latest  $DOCKER_USERNAME/tq-frontend-desktop:latest
docker push $DOCKER_USERNAME/tq-frontend-desktop:latest

docker tag tq-frontend-web-light:latest  $DOCKER_USERNAME/tq-frontend-web-light:latest
docker push $DOCKER_USERNAME/tq-frontend-web-light:latest

docker tag tq-frontend-web:latest  $DOCKER_USERNAME/tq-frontend-web:latest
docker push $DOCKER_USERNAME/tq-frontend-web:latest

