resource "aws_ecr_repository" "backend_repo" {
  name                 = "${var.project_name}-backend"
  image_tag_mutability = "MUTABLE"
  force_delete = true  //just for demo to be able to destroy all resources
  image_scanning_configuration {
    scan_on_push = true
  }
}