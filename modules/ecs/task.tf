resource "aws_ecs_task_definition" "task" {
  family = "teste"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([
    {
      "cpu": 256,
      "essential": true,
      "networkMode": "awsvpc",
      "image": format("%s:%s", aws_ecr_repository.repo.repository_url, var.tag),
      "memory": 512,
      "name": "api_desafio_devops",
      "portMappings": [
        {
          "containerPort": 8000,
          "hostPort": 8000
        }
      ],
    }
  ])

  cpu = 256
  memory = 512

  execution_role_arn = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn = aws_iam_role.ecsTaskExecutionRole.arn
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "ecs-tasks.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
  )
}