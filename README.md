# FullStack Forge

An end-to-end DevOps project demonstrating a fully automated CI/CD pipeline deploying a Go web application to Azure Kubernetes Service (AKS).

## Stack

- **Go** — HTTP server with `/` and `/health` endpoints
- **Docker** — multi-stage image build
- **Azure Container Registry (ACR)** — private image registry
- **Azure Kubernetes Service (AKS)** — container orchestration
- **Jenkins** — CI/CD pipeline (running in Docker)
- **Ansible** — environment verification and AKS node configuration

## Architecture

```
GitHub → Jenkins → Docker Build → ACR → AKS
                ↓
            Ansible
        (verify env + label nodes)
```

## Pipeline Stages

1. **Checkout** — pulls latest code from GitHub
2. **Ansible - Verify Environment** — confirms Docker, Azure CLI, and kubectl are available in Jenkins
3. **Build** — builds Docker image tagged with Jenkins build number
4. **Push to ACR** — pushes image to Azure Container Registry
5. **Ansible - Configure AKS Nodes** — labels nodes with `environment=production`
6. **Deploy to AKS** — rolls out new image to AKS deployment

## Running Locally

```bash
go run cmd/main.go
curl http://localhost:8080/health
```

## Infrastructure

- **Resource Group:** fullstack-forge-rg
- **ACR:** fullstackforgeacr.azurecr.io
- **AKS Cluster:** fullstack-forge-aks (1 node, Standard_D2s_v3)
- **Node Label:** environment=production
