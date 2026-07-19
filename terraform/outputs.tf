#############################################
# EKS Outputs
#############################################

output "cluster_name" {
  description = "Amazon EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_id" {
  description = "Amazon EKS Cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Amazon EKS Cluster Endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "EKS Cluster Security Group ID"
  value       = module.eks.cluster_security_group_id
}

output "oidc_provider_arn" {
  description = "OIDC Provider ARN"
  value       = module.eks.oidc_provider_arn
}

#############################################
# IAM Outputs
#############################################

output "karpenter_controller_iam_role_arn" {
  description = "Karpenter Controller IAM Role ARN"
  value       = module.iam.karpenter_controller_iam_role_arn
}

output "karpenter_node_role_name" {
  description = "Karpenter Node IAM Role Name"
  value       = module.iam.karpenter_node_role_name
}

output "karpenter_node_role_arn" {
  description = "Karpenter Node IAM Role ARN"
  value       = module.iam.karpenter_node_role_arn
}

#############################################
# Karpenter Outputs
#############################################

output "karpenter_helm_release" {
  description = "Karpenter Helm Release Name"
  value       = module.karpenter.helm_release_name
}

#############################################
# NGINX Ingress Outputs (disabled for now - setup later)
#############################################

# output "ingress_nginx_release" {
#   description = "NGINX Ingress Helm Release"
#   value       = module.ingress_nginx.release_name
# }

# output "ingress_nginx_namespace" {
#   description = "NGINX Ingress Namespace"
#   value       = module.ingress_nginx.release_namespace
# }
