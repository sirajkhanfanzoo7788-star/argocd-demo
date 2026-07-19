#############################################
# EKS Module
#############################################

module "eks" {
  source = "./modules/eks"

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  environment        = var.environment
}

#############################################
# IAM Module
#############################################

module "iam" {
  source = "./modules/iam"

  cluster_name = module.eks.cluster_name
  environment  = var.environment
}

#############################################
# Karpenter Module
#############################################

module "karpenter" {
  source = "./modules/karpenter"

  cluster_name             = module.eks.cluster_name
  # queue_name              = module.iam.karpenter_queue_name
  iam_role_arn             = module.iam.karpenter_controller_iam_role_arn
  karpenter_node_role_name = module.iam.karpenter_node_role_name

  depends_on = [
    module.eks,
    module.iam
  ]
}

#############################################
# NGINX Ingress Module (disabled for now - setup later)
#############################################

# module "ingress_nginx" {
#   source = "./modules/ingress-nginx"
#
#   depends_on = [
#     module.eks
#   ]
# }