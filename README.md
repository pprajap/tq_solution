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
export DOCKER_USERNAME=<your_username>
export DOCKER_PASSWORD=<your_password>
```

This script will internally call `build_docker_images.sh` before starting.
```sh
./push_docker_images.sh
```

# Start Desktop/Web Solution

Have fun! Have a coffee or two! talk physics & quantums & be back after 30 mins or so..


# Setting up Google Cloud
# install and authenticate google cloud sdk
gcloud init
gcloud auth login
gcloud config set project YOUR_PROJECT_ID

# create GKE cluster
gcloud container clusters create my-cluster --num-nodes=3
Note: The Kubelet readonly port (10255) is now deprecated. Please update your workloads to use the recommended alternatives. See https://cloud.google.com/kubernetes-engine/docs/how-to/disable-kubelet-readonly-port for ways to check usage and for migration instructions.
Note: Your Pod address range (`--cluster-ipv4-cidr`) can accommodate at most 1008 node(s).
Creating cluster my-cluster in europe-west2-a... Cluster is being health-checked (Kubernetes Control Plane is healthy)...done.  
Created [https://container.googleapis.com/v1/projects/model-union-438013-a7/zones/europe-west2-a/clusters/my-cluster].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/europe-west2-a/my-cluster?project=model-union-438013-a7
kubeconfig entry generated for my-cluster.
NAME        LOCATION        MASTER_VERSION      MASTER_IP     MACHINE_TYPE  NODE_VERSION        NUM_NODES  STATUS
my-cluster  europe-west2-a  1.30.5-gke.1014001  34.39.18.211  e2-medium     1.30.5-gke.1014001  3          RUNNING

# interact with created GKE cluster using kubectl on your host machine
gcloud container clusters get-credentials my-cluster

# generate service & deployment kubernetes manifests
kompose convert -f docker-compose-web.yml
this will generate necessary kubernetes manifests for your services, deployments, and other resources.
they are not always perfect and often require corrections. eg. to make your services accessible from outside the cluster, the service definitions to use LoadBalancer.
INFO Network tq_network is detected at Source, shall be converted to equivalent NetworkPolicy at Destination 
INFO Network tq_network is detected at Source, shall be converted to equivalent NetworkPolicy at Destination 
INFO Kubernetes file "tq-backend-service.yaml" created 
INFO Kubernetes file "tq-frontend-web-service.yaml" created 
INFO Kubernetes file "tq-backend-deployment.yaml" created 
INFO Kubernetes file "tq_network-networkpolicy.yaml" created 
INFO Kubernetes file "tq-frontend-web-deployment.yaml" created 
INFO Kubernetes file "tq_network-networkpolicy.yaml" created 

# apply manifests..
kubectl apply -f tq_network-networkpolicy.yaml
kubectl apply -f tq-backend-service.yaml
kubectl apply -f tq-backend-deployment.yaml
kubectl apply -f tq-frontend-web-service.yaml
kubectl apply -f tq-frontend-web-deployment.yaml

# verify
kubectl get services