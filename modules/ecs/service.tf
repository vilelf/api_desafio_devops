resource "aws_ecs_service" "service" {
  name = "api_desafio_devops"
  cluster = aws_ecs_cluster.api_cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count = 3
  launch_type = "FARGATE"

  load_balancer {
    container_name = "api_desafio_devops"
    container_port = 80
    target_group_arn = aws_lb_target_group.api_tg.arn
  }

  network_configuration {
    security_groups = [aws_security_group.lb.id]
    assign_public_ip = true
    subnets = [
      aws_default_subnet.default_az1.id, 
      aws_default_subnet.default_az2.id
    ]
  }
}

resource "aws_security_group" "lb" {
  name        = "load-balancer"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}