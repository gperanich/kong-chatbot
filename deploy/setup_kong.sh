#!/bin/bash

# deploy kong
kubectl create ns kong

helm repo add kong https://charts.konghq.com

helm repo update

kubectl create secret tls kong-cluster-cert -n kong --cert=tls.crt --key=tls.key

helm upgrade -i kong kong/kong -n kong --values ./values.yaml

# deploy redis
kubectl create ns redis

kubectl apply -f ./redis.yaml -n redis


# deploy ollama model
kubectl create ns llm

kubectl apply -n llm -f ./llm.yaml

kubectl apply -n llm -f ./embeddings.yaml