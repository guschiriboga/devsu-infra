#Backend variables
resource "circleci_environment_variable" "aws_region" {
  name  = "AWS_REGION"
  value     = var.region
  project = var.repos_info["backend"]
}

resource "circleci_environment_variable" "aws_ecr_registry_id" {
  project = var.repos_info["backend"]
  name  = "AWS_ECR_REGISTRY_ID"
  value     = var.backend_ecr_id
}

resource "circleci_environment_variable" "aws_ecr_registry_name" {
  project = var.repos_info["backend"]
  name  = "AWS_ECR_REGISTRY_NAME"
  value     = var.backend_ecr_name
}

resource "circleci_environment_variable" "aws_eks_cluster_name" {
  project = var.repos_info["backend"]
  name  = "AWS_EKS_CLUSTER_NAME"
  value     = var.eks_cluster_name
}