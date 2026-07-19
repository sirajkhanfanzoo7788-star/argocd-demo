output "karpenter_controller_iam_role_arn" {
  description = "Karpenter Controller IAM Role ARN"
  value       = module.karpenter.iam_role_arn
}

output "karpenter_node_role_name" {
  description = "Karpenter Node IAM Role Name"
  value       = aws_iam_role.karpenter_node.name
}

output "karpenter_node_role_arn" {
  description = "Karpenter Node IAM Role ARN"
  value       = aws_iam_role.karpenter_node.arn
}

# output "karpenter_queue_name" {
#   description = "Karpenter SQS Queue Name"
#   value       = aws_sqs_queue.karpenter.name
# }
