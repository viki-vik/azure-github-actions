# AKS Deployment with GitHub Actions, Terraform, and Helm

This repository provides a **secure deployment pipeline** using:

- **Azure Kubernetes Service (AKS)** (private API endpoint)
- **Azure Container Registry (ACR)**
- **Private DNS Zone** for AKS control plane
- **NGINX Ingress Controller** (via Helm)
- **Terraform (modular setup)** for infrastructure
- **GitHub Actions** for CI/CD and application deployment
- **DevSecOps**: container scanning, secrets management, and versioned Helm releases
- **Next.js sample application** (forked from [arikbidny/nextjsbasicapp](https://github.com/arikbidny/nextjsbasicapp))

---

## Project Structure

```plaintext
.
├── .github/workflows/                 # CI/CD pipeline
│   └── deploy-aks.yaml                # Terraform provisioning + tfsec + Ingress install
│   └── deploy.yaml                    # App CI/CD + image scanning + Helm ( + TLS can be enabled later with cert-manager)
├── nextjsbasicapp/                    # Forked Next.js app (Dockerized)
│   └── Dockerfile
├── helm/
│   └── nextjsapp/                     # Helm chart for nextjs app deployment
├── infra/                             # Terraform infrastructure
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   └── modules/
│       ├── acr/
│       ├── aks/
│       ├── dns/
│       └── network/
└── README.md
```

## Features
* Private AKS cluster — no public API access
* ACR integrated with AKS via managed identity
* Private DNS zone for control plane resolution
* NGINX Ingress Controller on AKS
* Secure CI/CD pipeline with Docker image scanning
* Helm-based deployment with rollback/versioning
* App deployed via GitHub Actions from code changes
* DevSecOps practices: minimal permissions, secret injection, image scanning

## Prerequisites
- Azure CLI (az)
- Terraform >= 1.9
- Docker
- Helm
- GitHub repo + GitHub Actions Runner

#### Setup Azure Credentials for GitHub Actions
1. Create Azure Service Principal:

```bash
az ad sp create-for-rbac --name "gh-aks-deployer" \
  --role contributor \
  --scopes /subscriptions/<subscription-id> \
  --sdk-auth
```

2. Save output to GitHub Secrets:

- Go to your GitHub repo → Settings → Secrets → Actions.
- Create secret `AZURE_CREDENTIALS` with full JSON output

## Deploy Infrastructure by Manual Trigger
Go to GitHub repo → **Actions** → **Deploy AKS with ACR and Ingress** and click **Run workflow**. This will provision on Azure:

- Resource group
- VNet, Subnet
- ACR
- AKS cluster (private)
- Private DNS zone

##### Monitor Deployment Progress
Watch the live logs in GitHub Actions:
- Navigate to the Actions tab
- Click "Deploy AKS with ACR and Ingress"
- View logs for each step: Terraform init, apply, etc.

##### Validate Ingress Controller on AKS
After deployment:

```bash
kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx
```

You should see a LoadBalancer service with internal IP (e.g. 10.0.x.x)
Verify app’s ingress with:

```bash
kubectl get ingress
```

# Deploy Application 

## GitHub Actions CI/CD Flow
Deploys the Next.js app with Helm Chart
##### What It Does:
- Logs into Azure and ACR
- Scans Docker image using Trivy
- Builds and tags Docker image with a timestamp
- Pushes image to ACR
- Pulls AKS credentials
- Deploys the app using Helm (with versioned tag)

# Secure Features:

| Practice                   | Details                                                              |
|----------------------------|----------------------------------------------------------------------|
| Image Scanning             | Trivy used to scan Docker images for vulnerabilities                 |
| Least-privileged Azure SP  | Scoped SP with Contributor only on subscription                      |
| Secrets Management         | Stored in GitHub Secrets                                             |
| No Public AKS API Access   | Cluster is private with Private DNS zone                             |
| CI/CD Hardening            | Uses GitHub-hosted runners with environment isolation                |
| Helm Rollback              | Versioned tags allow safe rollback of deployments                    |
