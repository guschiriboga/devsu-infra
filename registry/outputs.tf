output "backend_ecr_id" {
  value = aws_ecr_repository.backend_repo.registry_id
}

output "backend_ecr_name" {
  value = "${var.project_name}-backend"
}