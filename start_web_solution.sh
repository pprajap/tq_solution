#!/bin/bash

# Stop and remove all containers, networks, and volumes
docker-compose -f docker-compose-web.yml down -v

# Build the Docker Compose services
docker-compose -f docker-compose-web.yml build --no-cache

# Start Docker Compose
docker-compose -f docker-compose-web.yml up

# echo "Frontend service is running. Visit http://localhost:3000/apptq_frontend.html"
echo "Frontend is running. Visit http://localhost:3000/apptq_frontend.html"
