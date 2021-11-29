output "ecr_repo" {
  value = aws_ecr_repository.repo.repository_url
}