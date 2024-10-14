#!/bin/bash

# Stop and remove all containers, networks, and volumes
docker-compose down -v

# Build the Docker Compose services
docker-compose build --no-cache

# Start Docker Compose
docker-compose up
