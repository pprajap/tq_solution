#!/bin/bash

echo "Building tq-reverse-proxy image..."
# build tq-reverse-proxy image
docker build -f Dockerfile -t tq-reverse-proxy .
echo "Image build completed."
