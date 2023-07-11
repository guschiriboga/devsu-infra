module "network" {
  source = "./network"

  cidr_info    = var.cidr_info
  project_name = var.project_name
}

module "ecr" {
  source = "./registry"

  project_name = var.project_name
}

module "circleci" {
  source = "./circleci"

  cci_context_name = var.project_name
}