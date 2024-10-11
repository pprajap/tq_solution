#!/bin/bash

# build the docker compose
docker-compose build

# Allow local Docker containers to access the X server
xhost +local:docker

# Start Docker Compose
docker-compose up