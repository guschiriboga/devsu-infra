output "aws_access_keys_circleci" {
  value = aws_iam_access_key.aws_access_key_circleci
  description = "Access keys for CircleCI"
}
