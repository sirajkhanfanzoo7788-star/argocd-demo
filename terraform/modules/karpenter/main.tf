#############################################
# Karpenter Helm Deployment
#############################################

resource "helm_release" "karpenter" {

  name             = "karpenter"
  namespace        = "kube-system"
  create_namespace = true

  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "1.6.0"

  values = [
    yamlencode({

      settings = {
        clusterName = var.cluster_name
      }

      serviceAccount = {
        annotations = {
          "eks.amazonaws.com/role-arn" = var.iam_role_arn
        }
      }

      controller = {
        resources = {
          requests = {
            cpu    = "1"
            memory = "1Gi"
          }
          limits = {
            cpu    = "2"
            memory = "2Gi"
          }
        }
      }

    })
  ]

}


#############################################
# EC2NodeClass
#############################################

resource "kubectl_manifest" "karpenter_node_class" {

  yaml_body = <<-YAML

apiVersion: karpenter.k8s.aws/v1
kind: EC2NodeClass

metadata:
  name: default

spec:

  role: ${var.karpenter_node_role_name}

  amiSelectorTerms:
    - alias: al2023@latest

  subnetSelectorTerms:
    - tags:
        karpenter.sh/discovery: ${var.cluster_name}

  securityGroupSelectorTerms:
    - tags:
        karpenter.sh/discovery: ${var.cluster_name}

  tags:
    Project: ${var.cluster_name}
    Environment: dev
    ManagedBy: Terraform

YAML


  depends_on = [
    helm_release.karpenter
  ]

}


#############################################
# NodePool
#############################################

resource "kubectl_manifest" "karpenter_node_pool" {

  yaml_body = <<-YAML

apiVersion: karpenter.sh/v1
kind: NodePool

metadata:
  name: default

spec:

  template:

    metadata:
      labels:
        workload: karpenter

    spec:

      nodeClassRef:
        name: default
        group: karpenter.k8s.aws
        kind: EC2NodeClass


      requirements:

        - key: kubernetes.io/arch
          operator: In
          values:
            - amd64


        - key: karpenter.sh/capacity-type
          operator: In
          values:
            - spot
            - on-demand


        - key: node.kubernetes.io/instance-type
          operator: In
          values:
            - t3.small


  limits:
    cpu: 100


  disruption:

    consolidationPolicy: WhenEmptyOrUnderutilized

    consolidateAfter: 30s


YAML


  depends_on = [
    kubectl_manifest.karpenter_node_class
  ]

}