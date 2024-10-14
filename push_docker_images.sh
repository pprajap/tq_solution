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
docker tag tq_backend:latest  $DOCKER_USERNAME/tq_backend:latest
docker push $DOCKER_USERNAME/tq_backend:latest

docker tag tq_frontend_desktop:latest  $DOCKER_USERNAME/tq_frontend_desktop:latest
docker push $DOCKER_USERNAME/tq_frontend_desktop:latest

docker tag tq_frontend_web_light:latest  $DOCKER_USERNAME/tq_frontend_web_light:latest
docker push $DOCKER_USERNAME/tq_frontend_web_light:latest

docker tag tq_frontend_web:latest  $DOCKER_USERNAME/tq_frontend_web:latest
docker push $DOCKER_USERNAME/tq_frontend_web:latest

