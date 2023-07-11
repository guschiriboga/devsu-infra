variable "region" {
  description = "AWS Region"
}

variable "cci_context_name" {
  description = "CircleCI organization context name"
}

variable "backend_ecr_url" {
  description = "AWS ECR url for backend"
}

variable "aws_access_keys_circleci" {
  description = "Access key ID for CircleCI"
}