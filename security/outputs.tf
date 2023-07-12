output "eks-iam-role" {
  value = aws_iam_role.eks-iam-role
}

output "eks-iam-role-workernode" {
  value = aws_iam_role.eks-workernodes_iam_role
}

output "eks-workernode-policy" {
  value = aws_iam_role_policy_attachment.eks-workernodes_policy
}

output "eks-cni-policy" {
  value = aws_iam_role_policy_attachment.eks_cni_policy
}

output "ecr-readonly-eks-workernodes" {
  value = aws_iam_role_policy_attachment.ecr-readonly-eks-workernodes
}