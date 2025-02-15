#!/bin/bash

# deploy kong
kubectl delete ns kong

# deploy redis
kubectl delete ns redis

# deploy ollama model
kubectl delete ns llm