# tq_solution

This project provides a comprehensive solution for setting up and managing a desktop/web application using Docker and Kubernetes on Google Cloud. It includes scripts for building and pushing Docker images, starting the application, and configuring Google Cloud resources.

## Index
- [tq\_solution](#tq_solution)
  - [Index](#index)
  - [Pipeline Status](#pipeline-status)
  - [Project live!](#project-live)
  - [Quick Start Desktop/Web Solution on your local machine](#quick-start-desktopweb-solution-on-your-local-machine)
  - [Build All Docker Images](#build-all-docker-images)
  - [Push All Docker Images to Docker Hub](#push-all-docker-images-to-docker-hub)
  - [Setting Up Google Cloud](#setting-up-google-cloud)
    - [Set Variables](#set-variables)
    - [Install and Authenticate Google Cloud SDK](#install-and-authenticate-google-cloud-sdk)
    - [Create GKE Cluster](#create-gke-cluster)
    - [Interact with Created GKE Cluster Using kubectl on Your Host Machine](#interact-with-created-gke-cluster-using-kubectl-on-your-host-machine)
    - [Generate Kubernetes Manifests to Cluster](#generate-kubernetes-manifests-to-cluster)
    - [Verify](#verify)
    - [Upgrade/Rolling Restart of the Nodes in the Cluster](#upgraderolling-restart-of-the-nodes-in-the-cluster)

## Pipeline Status
[![CI/CD Pipeline][def]](https://github.com/pprajap/tq_solution/actions/workflows/ci-cd.yml)

## Project live!
http://34.32.71.110:3000/apptq_frontend.html

## Quick Start Desktop/Web Solution on your local machine
```sh
./start_desktop_solution.sh 
```
OR
```sh
./start_web_solution.sh 
```
Note: do you have mac / windows? make sure you read https://github.com/pprajap/tq_frontend/blob/main/README.md to set up necessary environment

## Build All Docker Images
```sh
./build_docker_images.sh
```

## Push All Docker Images to Docker Hub
```sh
./push_docker_images.sh
```

## Setting Up Google Cloud

### Set Variables
```sh
CLUSTER_NAME="your-cluster-name"
ZONE="your-cluster-zone"
```

### Install and Authenticate Google Cloud SDK
```sh
gcloud init
gcloud auth login
gcloud config set project YOUR_PROJECT_ID
```

### Create GKE Cluster
```sh
gcloud container clusters create $CLUSTER_NAME --num-nodes=3 --zone=$ZONE
```

### Interact with Created GKE Cluster Using kubectl on Your Host Machine
```sh
gcloud container clusters get-credentials $CLUSTER_NAME --zone=$ZONE
```

### Generate Kubernetes Manifests to Cluster
1. Download latest Kompose:
  ```sh
  # Download and install Kompose
  curl -L https://github.com/kubernetes/kompose/releases/latest/download/kompose-linux-amd64 -o kompose
  chmod +x kompose
  sudo mv kompose /usr/local/bin/kompose
  ```

2. Convert Docker Compose to Kubernetes Manifests:
  ```sh
  kompose convert -f docker-compose-web.yml
  ```

3. Apply the Manifests:
  ```sh
  kubectl apply -f k8_manifests/.
  ```

### Verify
```sh
kubectl get services
kubectl get deployments
kubectl get pods
kubectl get nodes
```

### Upgrade/Rolling Restart of the Nodes in the Cluster
1. Get the Current Node Version:
  ```sh
  CURRENT_NODE_VERSION=$(gcloud container clusters describe $CLUSTER_NAME --zone $ZONE --format="get(currentNodeVersion)")
  ```

2. Upgrade the Nodes to the Same Version to Restart Them:
  ```sh
  gcloud container clusters upgrade $CLUSTER_NAME --zone $ZONE --cluster-version $CURRENT_NODE_VERSION
  ```

[def]: https://github.com/pprajap/tq_solution/actions/workflows/ci-cd.yml/badge.svg?branch=main