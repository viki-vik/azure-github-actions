## Secure Development Lifecycle Diagram

```plaintext
+--------------------+
| Developer Workstation |
+--------------------+
         |
         v
+--------------------+
| Source Code Management |
| (GitHub / Azure Repos) |
+--------------------+
         |
         v
+---------------------+
| Pre-Commit Hooks    |
| - Secrets Scan (gitleaks) |
| - Lint / Format     |
+---------------------+
         |
         v
+------------------------+
| CI/CD Pipeline (GitHub Actions) |
+------------------------+
         |
         v
+----------------------------+
| Build Stage                |
| - Docker Build             |
| - Image Tagging            |
| - Dependency Scanning (Trivy) |
+----------------------------+
         |
         v
+-----------------------------+
| Test Stage                 |
| - Unit Tests               |
| - SAST (SonarQube, Bandit) |
| - Lint (ESLint, TFLint)    |
+-----------------------------+
         |
         v
+------------------------------+
| Security & Compliance Checks |
| - IaC scan (tfsec, Checkov)  |
| - Container Scan             |
| - License Check (FOSSA)      |
+------------------------------+
         |
         v
+-----------------------------+
| Sign & Push to Registry     |
| - Sign image (cosign)       |
| - Push to ACR / DockerHub   |
+-----------------------------+
         |
         v
+------------------------------+
| Deploy to Staging (AKS)      |
| - Helm Deploy                |
| - Secrets from Key Vault     |
| - TLS Ingress + WAF Rules    |
+------------------------------+
         |
         v
+------------------------------+
| Manual or Auto Promotion     |
| - Approval gates             |
| - GitOps tag/release         |
+------------------------------+
         |
         v
+-------------------------------+
| Production Deployment         |
| - Canary / Blue-Green Deploy  |
| - Auto Rollback via Helm      |
| - Monitoring + Alerts         |
+-------------------------------+
```

---

##  Secure Development Cycle
Starts from the Developer Workstation and ends in the Deployment Environment.

---

### 1. **Developer Workstation**

- Developers use **secure machines** with policies (MFA, VPN, EDR)
- Code is written in IDEs with **plugins for linting and scanning**

---

### 2. **Source Code Management (SCM)**

- GitHub, GitLab, or Azure Repos used
- Access controlled via **SSO / RBAC**
- Protected branches, PR reviews, code owners enforced

---

### 3. **Pre-Commit Security Hooks**

- Use `pre-commit` framework
- Enforce:
  - `gitleaks` for secrets
  - Linting (YAML, JS/TS, Terraform)
  - Formatting (Prettier, gofmt)

---

### 4. **CI/CD Pipeline**

- Triggered by PRs or commits to protected branches
- Runs on **GitHub Actions / Azure DevOps**
- Builds Docker images and artifacts

---

### 5. **Build Stage**

- **Build container images** using multi-stage Dockerfiles
- Tag images with `git SHA`, timestamp, or version
- **Run Trivy** to scan for CVEs in OS + app layer

---

### 6. **Test Stage**

- Run:
  - **Unit tests** (Jest, pytest, etc.)
  - **Static Application Security Testing (SAST)** (Bandit, SonarQube)
  - **Code Quality checks** (ESLint, flake8, etc.)

---

### 7. **Security & Compliance Checks**

- **Terraform Scanning** (`tfsec`, `checkov`)
- Validate:
  - No public S3 buckets / IPs
  - Least-privilege IAM roles
- **License scanning** for compliance (FOSSA, WhiteSource)

---

### 8. **Sign & Push to Registry**

- Use **Cosign/Sigstore** to sign images
- Push to **Azure Container Registry (ACR)** or private DockerHub
- Validate before promotion

---

### 9. **Deploy to Staging**

- Use **Helm charts** with versioned releases
- Inject secrets securely via:
  - **Azure Key Vault CSI Driver**
  - **AAD Pod Identity**

- Expose app with **NGINX Ingress** + TLS + **WAF rules**

---

### 10. **Promotion to Production**

- Triggered via:
  - GitHub environment approval gates
  - GitOps tag (e.g. `v1.2.0`)
- Optional **canary or blue/green deployments**
- Auto rollback if:
  - Probes fail
  - Errors spike

---

### 11. **Monitoring, Audit & Alerting**

- **Prometheus + Grafana** for metrics
- **Azure Monitor + Log Analytics**
- **Alert rules** for SLOs, SLA, anomaly detection
- **Audit logs** for pipeline and user actions

---

## Security Highlights at Every Step

| Stage         | Security Feature                          |
|---------------|--------------------------------------------|
| SCM           | MFA, RBAC, branch protection               |
| CI/CD         | Secretless access via OIDC                 |
| Container     | Image scanning, signature validation       |
| IaC           | tfsec/checkov for config compliance        |
| Deploy        | TLS, WAF, Key Vault integration            |
| Monitoring    | Defender for Cloud, Sentinel alerts        |
