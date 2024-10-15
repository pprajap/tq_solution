#!/bin/bash

# call ./tq_backend/build_push_backend_docker_image.sh to build and push backend image
echo "Building and pushing backend Docker image..."
if [ -d "tq_backend" ]; then
  cd tq_backend
  ./build_push_backend_docker_image.sh
  cd ..
  echo "Backend Docker image built and pushed."
else
  echo "Error: tq_backend directory not found."
  exit 1
fi

# call ./tq_frontend/build_push_frontend_desktop_docker_image.sh to build and push frontend desktop image
echo "Building and pushing frontend desktop Docker image..."
if [ -d "tq_frontend" ]; then
  cd tq_frontend
  ./build_push_frontend_desktop_docker_image.sh
  cd ..
  echo "Frontend desktop Docker image built and pushed."
else
  echo "Error: tq_frontend directory not found."
  exit 1
fi

# call ./tq_frontend/build_push_frontend_web_light_docker_image.sh to build and push frontend web light image
echo "Building and pushing frontend web light Docker image..."
if [ -d "tq_frontend" ]; then
  cd tq_frontend
  ./build_push_frontend_web_light_docker_image.sh
  cd ..
  echo "Frontend web light Docker image built and pushed."
else
  echo "Error: tq_frontend directory not found."
  exit 1
fi