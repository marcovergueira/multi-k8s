#!/bin/bash

docker build -t marcovergueira/multi-client:latest -t marcovergueira/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marcovergueira/multi-server:latest -t marcovergueira/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marcovergueira/multi-worker:latest -t marcovergueira/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marcovergueira/multi-client:latest
docker push marcovergueira/multi-server:latest
docker push marcovergueira/multi-worker:latest

docker push marcovergueira/multi-client:$SHA
docker push marcovergueira/multi-server:$SHA
docker push marcovergueira/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=marcovergueira/multi-server:$SHA
kubectl set image deployments/client-deployment client=marcovergueira/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=marcovergueira/multi-worker:$SHA
