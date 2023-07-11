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
}

resource "aws_iam_user_policy" "aws_user_policy_circleci" {
  name   = aws_iam_policy.cci_user_policy.name
  policy = aws_iam_policy.cci_user_policy.policy
  user   = aws_iam_user.aws_cci_user.name
}

resource "aws_iam_access_key" "aws_access_key_circleci" {
  user = aws_iam_user.aws_cci_user.name
}