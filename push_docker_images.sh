#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

# Treat unset variables as an error
set -u

echo "Building all images..."
./build_docker_images.sh
echo "Images build completed."

# Docker login
docker login
echo "Docker login successful."

# fetch user name from docker login
export DOCKER_USERNAME=$(docker info | grep Username | awk '{print $2}')

# push all above to docker hub
docker tag tq-backend:latest  $DOCKER_USERNAME/tq-backend:latest
docker push $DOCKER_USERNAME/tq-backend:latest

docker tag tq-frontend-desktop:latest  $DOCKER_USERNAME/tq-frontend-desktop:latest
docker push $DOCKER_USERNAME/tq-frontend-desktop:latest

docker tag tq-frontend-web-light:latest  $DOCKER_USERNAME/tq-frontend-web-light:latest
docker push $DOCKER_USERNAME/tq-frontend-web-light:latest

docker tag tq-reverse-proxy:latest  $DOCKER_USERNAME/tq-reverse-proxy:latest
docker push $DOCKER_USERNAME/tq-reverse-proxy:latest
