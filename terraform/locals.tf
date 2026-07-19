#############################################
# Common Local Values
#############################################

locals {
  common_tags = {
    Project     = var.cluster_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}