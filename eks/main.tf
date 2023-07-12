resource "aws_eks_cluster" "eks" {
  name = "${var.project_name}-eks"
  role_arn = var.eks-iam-role.arn

  vpc_config {
    subnet_ids = var.public_subnet.*.id
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    var.eks-iam-role
  ]
}

resource "aws_eks_node_group" "workernodes-group" {
  cluster_name  = aws_eks_cluster.eks.name
  node_group_name = "workernodes-group"
  node_role_arn  = var.eks-iam-role-workernode.arn
  subnet_ids   = var.public_subnet.*.id
  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 1
    max_size   = 1
    min_size   = 1
  }

  depends_on = [
    var.eks-workernode-policy,
    var.eks-cni-policy,
    var.ecr-readonly-eks-workernodes,
  ]
}