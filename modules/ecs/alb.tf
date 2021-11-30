resource "aws_alb" "alb" {
  name = "api-desafio-devops"
  security_groups = [aws_security_group.lb.id]

  subnets = [
    aws_subnet.subnet_a.id, 
    aws_subnet.subnet_b.id, 
    aws_subnet.subnet_c.id
  ]
}

resource "aws_lb_target_group" "api_tg" {
  name = "api-desafio-devops"
  port = 8000
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
}