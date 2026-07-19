# Terraform AWS EKS with Karpenter

This project provisions a production-ready Amazon EKS cluster using Terraform. It deploys:

- Amazon EKS Cluster
- IAM Roles for EKS and Karpenter
- Karpenter Autoscaler
- NGINX Ingress Controller
- Existing VPC and Subnets

---

## Project Structure

payz365/
├── terraform/
│   ├── provider.tf
│   ├── versions.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── locals.tf
│   └── data.tf
│
├── modules/
│   ├── eks/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── iam/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── karpenter/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── ingress-nginx/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── docs/
│   └── README.md
│
└── examples/
    └── terraform.tfvars.example
```

---

## Prerequisites

- Terraform >= 1.6
- AWS CLI
- kubectl
- Helm
- AWS Account
- Existing VPC
- Existing Public and Private Subnets

---

## Providers

- AWS
- Helm
- Kubernetes
- Kubectl

---

## Usage

Initialize Terraform:

```bash
terraform init
```

Format the configuration:

```bash
terraform fmt
```

Validate the configuration:

```bash
terraform validate
```

Review the execution plan:

```bash
terraform plan
```

Deploy the infrastructure:

```bash
terraform apply
```

Destroy the infrastructure:

```bash
terraform destroy
```

---

## Features

- Amazon EKS Cluster
- IRSA Enabled
- Managed Node Group
- Karpenter Controller
- EC2NodeClass
- NodePool
- NGINX Ingress Controller
- AWS Default Tags
- Modular Terraform Structure

---

## Author

Siraj Ahmad