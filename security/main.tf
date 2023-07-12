# AWS IAM
resource "aws_iam_policy" "cci_user_policy" {
  name = "${var.project_name}-cci-user"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : "*",
          "Resource" : "*"
        }
      ]
    }
  )
}

# CircleCI
resource "aws_iam_user" "aws_cci_user" {
  name = "${var.project_name}-cci"
  force_destroy = true
}

resource "aws_iam_user_policy" "aws_user_policy_circleci" {
  name   = aws_iam_policy.cci_user_policy.name
  policy = aws_iam_policy.cci_user_policy.policy
  user   = aws_iam_user.aws_cci_user.name
}

#EKS
resource "aws_iam_role" "eks-iam-role" {
  name = "${var.project_name}-eks-iam-role"

  assume_role_policy = <<EOF
  {
   "Version": "2012-10-17",
   "Statement": [
    {
     "Effect": "Allow",
     "Principal": {
      "Service": [
					"eks.amazonaws.com",
					"ec2.amazonaws.com"
				]
     },
     "Action": "sts:AssumeRole"
    }
   ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_iam_role_policy_attachment" "ecr-readonly-eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-iam-role.name
}

resource "aws_iam_role" "eks-workernodes_iam_role" {
  name = "${var.project_name}-eks-node-group"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        "Service" : [
          "eks.amazonaws.com",
          "ec2.amazonaws.com"
        ]
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-workernodes_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-workernodes_iam_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-workernodes_iam_role.name
}

resource "aws_iam_role_policy_attachment" "ecr-container-builds-policy" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role       = aws_iam_role.eks-workernodes_iam_role.name
}

resource "aws_iam_role_policy_attachment" "ecr-readonly-eks-workernodes" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-workernodes_iam_role.name
}

resource "aws_security_group" "eks_nodes_sec_group" {
  name   = "${var.project_name}-eks-nodes-security-group"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = var.public_subnet.*.cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
