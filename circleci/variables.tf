variable "region" {
  description = "AWS Region"
}

variable "cci_context_name" {
  description = "CircleCI organization context name"
}

variable "backend_ecr_id" {
  description = "AWS ECR url for backend"
}

variable "backend_ecr_name" {
  description = "AWS ECR name for backend"
}

variable "repos_info" {
  description = "Repositories information"
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
}