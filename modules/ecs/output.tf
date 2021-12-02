output "ecr_repo" {
  value = aws_ecr_repository.repo.repository_url
}

output "subdominio" {
  value = aws_route53_record.subdominio.name
}