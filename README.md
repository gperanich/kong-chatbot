# Kong ChatBot

Webapp that uses self-hosted ollama models, redis vector database, and Kong AI Gateway to deliver a chatbot interface to users.

## Overview

The repository includes the following key files:
- `deploy/setup_kong.sh`: A shell script to deploy Kong Gateway and Redis.
- `deploy/values.yaml`: Configuration values for the Kong Gateway deployment.
- `deploy/redis.yaml`: Configuration file for Redis.
- `deploy/llm.yaml`: Deployment file for an ollama-based `qwen2.5:0.5b-instruct` model
- `deploy/embeddings.yaml`: Deployment file for an ollama-based `nomic-embed-text` model
- `deck/kong.yaml`: Example test cases for the workshop 
- `public` and `src`: VueJS-based ChatBot webapp

## Requirements
- local Kubernetes cluster
- nodejs ^v18.20.2

## Setup Environment

To set up the environment, follow these steps:

1. Clone the repository:
    ```sh
    git clone <repository-url>
    cd <repository-directory>
    ```

2. Run the setup script:
    ```sh
    cd deploy
    ./setup_kong.sh
    ```

3. Port Forward Kong
    ```sh
    kubectl port-forward -n kong svc/kong-proxy 8000:80
    ```

This script will:
- Create a namespace for Kong.
- Add the Kong Helm repository and update it.
- Create a TLS secret for Kong.
- Deploy Kong using Helm with the specified values in `values.yaml`.
- Create a namespace for Redis.
- Apply the Redis configuration from `redis.yaml`.
- Create a namespace for the LLMs
- Deploy the `qwen2.5:0.5b-instruct` and `nomic-embed-text` models

Ensure you have the necessary TLS certificate and key files (`tls.crt` and `tls.key`) in the appropriate directory before running the setup script.

## Start ChatBot

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```
