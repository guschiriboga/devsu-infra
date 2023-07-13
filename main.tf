module "network" {
  source = "./network"

  region       = var.region
  cidr_info    = var.cidr_info
  project_name = var.project_name
}

module "ecr" {
  source = "./registry"

  project_name = var.project_name
}

module "circleci" {
  source = "./circleci"

  region           = var.region
  cci_context_name = var.project_name
  backend_ecr_id   = module.ecr.backend_ecr_id
  repos_info       = var.repos_info
  backend_ecr_name = module.ecr.backend_ecr_name
  eks_cluster_name = module.eks.eks_cluster_name
}

module "security" {
  source = "./security"

  project_name  = var.project_name
  vpc_id        = module.network.vpc_id
  public_subnet = module.network.public_subnet
}

module "eks" {
  source = "./eks"

  project_name            = var.project_name
  eks-iam-role            = module.security.eks-iam-role
  eks-iam-role-workernode = module.security.eks-iam-role-workernode

  ecr-readonly-eks-workernodes = module.security.ecr-readonly-eks-workernodes
  eks-cni-policy               = module.security.eks-cni-policy
  eks-workernode-policy        = module.security.eks-workernode-policy
  public_subnet                = module.network.public_subnet
}