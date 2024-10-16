# tq_solution

# Pipeline status
[![CI/CI Pipeline](https://github.com/pprajap/tq_solution/actions/workflows/ci-cd.yml/badge.svg?branch=main)](https://github.com/pprajap/tq_solution/actions/workflows/ci-cd.yml)

# Build All Docker Images
```sh
./build_docker_images.sh
```
# Push All Docker images to docker hub
```sh
./push_docker_images.sh
```

# Start Desktop/Web Solution
```sh
./start_desktop_solution.sh 
```
OR
```sh
./start_web_solution.sh 
```


# Generate kubernetes manifests out of docker-compose
```sh
cd k8_manifests
kompose convert -f ../docker-compose-web.yml
```

# Setting up Google Cloud

# Set variables
CLUSTER_NAME="your-cluster-name"
ZONE="your-cluster-zone"

# install and authenticate google cloud sdk
gcloud init
gcloud auth login
gcloud config set project YOUR_PROJECT_ID

# create GKE cluster
gcloud container clusters create <cluster-name> --num-nodes=3 --zone=<ZONE>

# interact with created GKE cluster using kubectl on your host machine
gcloud container clusters get-credentials <cluster-name> --zone=<ZONE>

# apply generated k8 manifests to cluster
kubectl apply -f k8_manifests/.

# verify
kubectl get services

# upgrade/ rolling restart of the nodes in the cluster
# Get the current node version
CURRENT_NODE_VERSION=$(gcloud container clusters describe $CLUSTER_NAME --zone $ZONE --format="get(currentNodeVersion)")

# Upgrade the nodes to the same version to restart them
gcloud container clusters upgrade $CLUSTER_NAME --zone $ZONE --cluster-version $CURRENT_NODE_VERSION



# setup CI/CD

1. Set Up GitHub Secrets
First, you need to set up the necessary secrets in your GitHub repository. Go to your repository settings and add the following secrets:

DOCKER_USERNAME: Your Docker Hub username.
DOCKER_PASSWORD: Your Docker Hub password.
GCP_PROJECT_ID: Your Google Cloud project ID.
GCP_SA_KEY: Your Google Cloud service account key in JSON format.
GKE_CLUSTER_NAME: Your GKE cluster name.
GKE_CLUSTER_ZONE: The zone where your GKE cluster is located.
2. Create GitHub Actions Workflow
Create a GitHub Actions workflow file in your repository. This file will define the CI/CD pipeline.

Create a file named .github/workflows/ci-cd.yml with the following content:

name: CI/CD Pipeline

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v1

    - name: Log in to Docker Hub
      uses: docker/login-action@v1
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}

    - name: Build and push tq-backend image
      run: |
        docker build -t ${{ secrets.DOCKER_USERNAME }}/tq-backend:latest -f tq_backend/Dockerfile ./tq_backend
        docker push ${{ secrets.DOCKER_USERNAME }}/tq-backend:latest

    - name: Build and push tq-frontend-desktop image
      run: |
        docker build -t ${{ secrets.DOCKER_USERNAME }}/tq-frontend-desktop:latest -f tq_frontend/qtdeskDockerfile ./tq_frontend
        docker push ${{ secrets.DOCKER_USERNAME }}/tq-frontend-desktop:latest

    - name: Build and push tq-frontend-web-light image
      run: |
        docker build -t ${{ secrets.DOCKER_USERNAME }}/tq-frontend-web-light:latest -f tq_frontend/qtwebDockerfile ./tq_frontend
        docker push ${{ secrets.DOCKER_USERNAME }}/tq-frontend-web-light:latest

    - name: Build and push tq-frontend-web image
      run: |
        docker build -t ${{ secrets.DOCKER_USERNAME }}/tq-frontend-web:latest -f tq_frontend/qtwasmDockerfile ./tq_frontend
        docker push ${{ secrets.DOCKER_USERNAME }}/tq-frontend-web:latest

  deploy:
    needs: build
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up Cloud SDK
      uses: google-github-actions/setup-gcloud@v0
      with:
        project_id: ${{ secrets.GCP_PROJECT_ID }}
        service_account_key: ${{ secrets.GCP_SA_KEY }}
        export_default_credentials: true

    - name: Configure Docker
      run: |
        gcloud auth configure-docker

    - name: Get GKE credentials
      run: |
        gcloud container clusters get-credentials ${{ secrets.GKE_CLUSTER_NAME }} --zone ${{ secrets.GKE_CLUSTER_ZONE }}

    - name: Update Kubernetes deployments
      run: |
        kubectl set image deployment/tq-backend tq-backend=${{ secrets.DOCKER_USERNAME }}/tq-backend:latest
        kubectl set image deployment/tq-frontend-web tq-frontend-web=${{ secrets.DOCKER_USERNAME }}/tq-frontend-web:latest
        kubectl set image deployment/tq-frontend-web-light tq-frontend-web-light=${{ secrets.DOCKER_USERNAME }}/tq-frontend-web-light:latest
        kubectl set image deployment/tq-frontend-desktop tq-frontend-desktop=${{ secrets.DOCKER_USERNAME }}/tq-frontend-desktop:latest

Explanation
Checkout code: Checks out the code from the repository.
Set up Docker Buildx: Sets up Docker Buildx for building multi-platform images.
Log in to Docker Hub: Logs in to Docker Hub using the provided credentials.
Build and push Docker images: Builds and pushes the Docker images for the backend and frontend services.
Set up Cloud SDK: Sets up the Google Cloud SDK using the provided service account key.
Configure Docker: Configures Docker to use Google Cloud credentials.
Get GKE credentials: Retrieves the credentials for the GKE cluster.
Update Kubernetes deployments: Updates the Kubernetes deployments with the new Docker images.


Summary
Set Up GitHub Secrets: Add the necessary secrets to your GitHub repository.
Create GitHub Actions Workflow: Create a workflow file to define the CI/CD pipeline.
Build and Push Docker Images: Build and push the Docker images to Docker Hub.
Update Kubernetes Deployments: Update the Kubernetes deployments with the new Docker images.
These steps will help you set up a CI/CD pipeline for your project, automating the process of building Docker images, pushing them to Docker Hub, and updating your GKE cluster to reflect the changes.