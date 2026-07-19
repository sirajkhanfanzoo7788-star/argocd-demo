variable "aws_region" {
  description = "AWS region where the EKS cluster will be deployed."
  type        = string
}

variable "cluster_name" {
  description = "Name of the Amazon EKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
}

variable "vpc_id" {
  description = "Existing VPC ID."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of existing private subnet IDs."
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of existing public subnet IDs."
  type        = list(string)
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}