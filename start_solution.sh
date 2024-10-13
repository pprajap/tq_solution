#!/bin/bash

# Stop and remove all containers, networks, and volumes
docker-compose -f docker-compose-images.yml down -v

# Build the Docker Compose services
docker-compose -f docker-compose-images.yml build

# Start Docker Compose
docker-compose -f docker-compose-images.yml up
