variable "project_name" {
  description = "Project name"
}

variable "eks-iam-role" {
  description = "EKS IAM role"
}

variable "eks-iam-role-workernode" {
  description = "EKS IAM role for workernodes"
}

variable "public_subnet" {
  description = "Public subnet ID"
}

variable "eks-workernode-policy" {
  description = "eks-workernode-policy"
}

variable "eks-cni-policy" {
  description = "eks-cni-policy"
}

variable "ecr-readonly-eks-workernodes" {
  description = "ecr-readonly-eks-workernodes"
}