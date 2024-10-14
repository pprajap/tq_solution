# tq_solution

# Start with a Clean Slate

**Warning:** This will remove all Docker containers and images.
```sh
./cleanup.sh
```

# Build All Docker Images

This script will internally call `cleanup.sh` before starting.
```sh
./build_docker_images.sh
```

# Upload/Push Docker Images to Docker Hub

Set your Docker Hub credentials:
```sh
export DOCKER_USERNAME="your_username"
export DOCKER_PASSWORD="your_password"
```

This script will internally call `build_docker_images.sh` before starting.
```sh
./push_docker_images.sh
```

# Start Desktop/Web Solution

Have fun!

