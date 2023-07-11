module "network" {
  source = "./network"

  cidr_info    = var.cidr_info
  project_name = var.project_name
}