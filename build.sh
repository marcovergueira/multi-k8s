#! /bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}>>> Setup minikube docker environment${NC}"
eval $(minikube docker-env)

echo -e "${GREEN}>>> Clean Kubernetes environment${NC}"
kubectl delete --wait=true -f k8s 2>/dev/null

echo -e "${GREEN}>>> Clean Docker images${NC}"
docker rmi multi-client -f 2>/dev/null
docker rmi multi-server -f 2>/dev/null
docker rmi multi-worker -f 2>/dev/null

echo -e "${GREEN}>>> Build Docker images${NC}"
docker build -t multi-client client
docker build -t multi-server server
docker build -t multi-worker worker

echo -e "${GREEN}>>> Setup Kubernetes environment${NC}"
kubectl apply -f k8s

echo -e "${GREEN}>>> Finished!${NC}"