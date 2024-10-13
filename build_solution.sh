#!/bin/bash

# Stop and remove all containers, networks, and volumes
docker-compose -f docker-compose-build.yml down -v

# Build the Docker Compose services
docker-compose -f docker-compose-build.yml build

