variable "cluster_name" {
  type = string
}

variable "queue_name" {
  type    = string
  default = null
}

variable "iam_role_arn" {
  type = string
}

variable "karpenter_node_role_name" {
  type = string
}