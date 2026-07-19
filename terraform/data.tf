#############################################
# AWS Region
#############################################

data "aws_region" "current" {}

#############################################
# Existing VPC
#############################################

data "aws_vpc" "selected" {
  id = var.vpc_id
}

#############################################
# Existing Private Subnets
#############################################

data "aws_subnet" "private" {
  for_each = toset(var.private_subnet_ids)

  id = each.value
}

#############################################
# Existing Public Subnets
#############################################

data "aws_subnet" "public" {
  for_each = toset(var.public_subnet_ids)

  id = each.value
}