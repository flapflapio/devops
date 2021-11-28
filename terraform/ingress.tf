# INGRESS FOR EKS
#
# This config should be used after running `main.tf` and configuring kubectl to
# point to the newly created EKS cluster.
#
# This config deploys the AWS Load Balancer controller on your EKS cluster. This
# controller is used for fulfilling kubernetes Ingress and type=LoadBalancer
# Service resources.
#
# It achieves this by communicating with the AWS API via OpenID Connect (OIDC)
# and provisioning the Application Load Balancers (ALBs) and Network Load
# Balancers (NLBs) dynamically.
#
# If you ran the `main.tf`, then you will already have OIDC configured on your
# cluster in order to provision the Fargate containers.
#
# LINKS:
#   - https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
#   - https://registry.terraform.io/providers/hashicorp/helm/latest/docs
#

# TODO:
resource "aws_iam_policy" "ingress-policy" {
}

# TODO:
resource "aws_iam_role" "ingress-role" {
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# TODO: change this to deploy the AWS Load Balancer Controller
resource "helm_release" "nginx_ingress" {
  name       = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"
  chart      = "eks/aws-load-balancer-controller"

  set {
    clusterName = ""
    region = "us-east-1"
    name  = "service.type"
    value = "ClusterIP"
  }
}