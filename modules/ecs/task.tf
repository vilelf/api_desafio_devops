resource "aws_ecs_task_definition" "task" {
  container_definitions = jsonencode([
    {
      "cpu": 128,
      "essential": true,
      "image": format("%s:%s", aws_ecr_repository.repo.repository_url, var.tag),
      "memory": 128,
      "name": "api_desafio_devops"
    }
  ])
}