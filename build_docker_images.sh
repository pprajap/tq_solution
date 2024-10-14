#!/bin/bash

# call ./cleanup.sh to remove all images and containers
# ./cleanup.sh

# build tq-backend image
docker build -f tq_backend/Dockerfile -t tq-backend ./tq_backend

# build tq-frontend-desktop image
docker build -f tq_frontend/qtdeskDockerfile -t tq-frontend-desktop ./tq_frontend

# build tq-frontend-web-light image
docker build -f tq_frontend/qtwasm_multistage_Dockerfile -t tq-frontend-web-light ./tq_frontend

# build tq-frontend-web-full image
docker build -f tq_frontend/qtwasmDockerfile -t tq-frontend-web ./tq_frontend
