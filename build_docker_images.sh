#!/bin/bash

# call ./tq_backend/build_backend_docker_image.sh to build backend image
./tq_backend/build_backend_docker_image.sh

# call ./tq_frontend/build_frontend_desktop_docker_image.sh to build frontend desktop image
./tq_frontend/build_frontend_desktop_docker_image.sh

# call ./tq_frontend/build_frontend_web_docker_image.sh to build frontend web image
./tq_frontend/build_frontend_web_docker_image.sh

# call ./reverse_proxy/build_reverse_proxy_docker_image.sh to build reverse proxy image
./reverse_proxy/build_reverse_proxy_docker_image.sh
