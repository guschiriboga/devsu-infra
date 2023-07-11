resource "circleci_context" "main-context" {
  name  = var.cci_context_name
}

resource "circleci_context_environment_variable" "aws_region" {
  variable  = "AWS_REGION"
  value     = var.region
  context_id = circleci_context.main-context.id
}

resource "circleci_context_environment_variable" "aws_ecr_registry_id" {
  variable  = "AWS_ECR_REGISTRY_ID"
  value     = var.backend_ecr_url
  context_id = circleci_context.main-context.id
}