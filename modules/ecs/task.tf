resource "aws_ecs_task_definition" "task" {
  family = "teste"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([
    {
      "cpu": 1024,
      "essential": true,
      "networkMode": "awsvpc",
      "image": format("%s:%s", aws_ecr_repository.repo.repository_url, var.tag),
      "memory": 2048,
      "name": "api_desafio_devops",
      "portMappings": [
        {
          "containerPort": 8000,
          "hostPort": 8000
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "cloudwatch-teste",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "api-desafio-devops"
        }
      }
    }
  ])

  cpu = 1024
  memory = 2048

  execution_role_arn = aws_iam_role.task_execution_role.arn
  task_role_arn = aws_iam_role.task_execution_role.arn
}

resource "aws_iam_role" "task_execution_role" {
  name = "ecs_task_execution_role"

  assume_role_policy = file(format("%s/policies/task_execution_role.json", path.module))
}

resource "aws_iam_role_policy" "execution_role_policy" {
  name = "ecs_task_execution_role_policy"
  policy = file(format("%s/policies/execution_role_policy.json", path.module))
  role = aws_iam_role.task_execution_role.id
}