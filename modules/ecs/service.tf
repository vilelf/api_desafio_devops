resource "aws_ecs_service" "service" {
  name = "api_desafio_devops"
  cluster = aws_ecs_cluster.api_cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count = 3
  launch_type = "FARGATE"

  load_balancer {
    container_name = "api_desafio_devops"
    container_port = 8000
    target_group_arn = aws_lb_target_group.api_tg.arn
  }
}

resource "aws_security_group" "lb" {
  name        = "load-balancer"
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}