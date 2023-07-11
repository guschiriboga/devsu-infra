module "network" {
  source = "./network"

  region = var.region
  cidr_info    = var.cidr_info
  project_name = var.project_name
}

module "ecr" {
  source = "./registry"

  project_name = var.project_name
}

module "circleci" {
  source = "./circleci"

  region = var.region
  cci_context_name = var.project_name
  backend_ecr_url = module.ecr.backend_ecr_url
  aws_access_keys_circleci = module.security.aws_access_keys_circleci
}

module "security" {
  source = "./security"

  project_name      = var.project_name
}