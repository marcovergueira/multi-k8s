## Setup Minikube
minikube start --cpus 4 --memory 4096

## Configure Ingress on Minikube
minikube addons enable ingress

## Build the project
./build.sh

