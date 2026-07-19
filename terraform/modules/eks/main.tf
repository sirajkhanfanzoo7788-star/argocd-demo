#############################################
# Amazon EKS Cluster
#############################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  #############################################
  # Cluster Endpoint
  #############################################

  endpoint_private_access = true
  endpoint_public_access  = true

  #############################################
  # Authentication
  #############################################

  authentication_mode = "API_AND_CONFIG_MAP"

  #############################################
  # IAM Roles for Service Accounts
  #############################################

  enable_irsa = true

  #############################################
  # Karpenter Discovery Tag on Node Security Group
  #############################################

  node_security_group_tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }

  #############################################
  # EKS Add-ons
  #############################################

  addons = {
    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    vpc-cni = {
      most_recent    = true
      before_compute = true
    }

    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  #############################################
  # Bootstrap Node Group
  #############################################

  eks_managed_node_groups = {

    bootstrap = {

      name = "${var.cluster_name}-bootstrap"

      ami_type = "AL2023_x86_64_STANDARD"

      instance_types = ["t3.small"]

      capacity_type = "ON_DEMAND"

      min_size     = 1
      max_size     = 3
      desired_size = 2

      disk_size = 50

      labels = {
        role = "bootstrap"
      }

      tags = local.common_tags
    }
  }

  #############################################
  # Cluster Admin Permissions
  #############################################

  enable_cluster_creator_admin_permissions = true

  tags = local.common_tags
}