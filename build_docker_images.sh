#!/bin/bash

# call ./tq_backend/build_push_backend_docker_image.sh to build and push backend image
echo "Building and pushing backend Docker image..."
cd tq_backend
./build_push_backend_docker_image.sh
cd ..
echo "Backend Docker image built and pushed."

# call ./tq_frontend/build_push_frontend_desktop_docker_image.sh to build and push frontend desktop image
echo "Building and pushing frontend desktop Docker image..."
cd tq_frontend
./build_push_frontend_desktop_docker_image.sh
cd ..
echo "Frontend desktop Docker image built and pushed."

# call ./tq_frontend/build_push_frontend_web_light_docker_image.sh to build and push frontend web light image
echo "Building and pushing frontend web light Docker image..."
cd tq_frontend
./build_push_frontend_web_light_docker_image.sh
cd ..
echo "Frontend web light Docker image built and pushed."
