resource "aws_ecs_task_definition" "task" {
  family = "%s"
  container_definitions = jsonencode([
    {
      "cpu": 128,
      "essential": true,
      "image": format("%s:%s", var.ecr_repo, var.tag),
      "memory": 128,
      "name": "api_desafio_devops"
    }
  ])
}