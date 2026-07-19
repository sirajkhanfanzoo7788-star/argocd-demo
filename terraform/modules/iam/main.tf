#############################################
# Karpenter Controller IAM Role
#############################################

module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "~> 21.0"

  cluster_name = var.cluster_name

  create_iam_role = true

  iam_role_name = "${var.cluster_name}-karpenter-controller"

  enable_spot_termination = false

  tags = local.common_tags
}

#############################################
# Karpenter Node IAM Role
#############################################

resource "aws_iam_role" "karpenter_node" {

  name = "${var.cluster_name}-karpenter-node"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = local.common_tags
}

#############################################
# Attach Required Policies
#############################################

resource "aws_iam_role_policy_attachment" "karpenter_worker" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "karpenter_cni" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "karpenter_registry" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

#############################################
# Allow Karpenter Controller to PassRole to Node Role
#############################################

resource "aws_iam_role_policy" "karpenter_pass_role" {
  name = "${var.cluster_name}-karpenter-pass-role"
  role = module.karpenter.iam_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "iam:PassRole"
        Resource = aws_iam_role.karpenter_node.arn
      }
    ]
  })
}

#############################################
# EKS Access Entry for Karpenter Node Role
#############################################

resource "aws_eks_access_entry" "karpenter_node" {
  cluster_name  = var.cluster_name
  principal_arn = aws_iam_role.karpenter_node.arn
  type          = "EC2_LINUX"

  tags = local.common_tags
}