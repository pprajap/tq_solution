#!/bin/bash

# call ./cleanup.sh to remove all images and containers
# ./cleanup.sh

# build tq_backend image
docker build -f tq_backend/Dockerfile -t tq_backend ./tq_backend

# build tq_frontend_desktop image
docker build -f tq_frontend/qtdeskDockerfile -t tq_frontend_desktop ./tq_frontend

# build tq_frontend_web_light image
docker build -f tq_frontend/qtwasm_multistage_Dockerfile -t tq_frontend_web_light ./tq_frontend

# build tq_frontend_web_full image
docker build -f tq_frontend/qtwasmDockerfile -t tq_frontend_web ./tq_frontend
