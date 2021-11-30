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
  target_type = "ip"

  depends_on = [aws_alb.alb]
}

resource "aws_lb_listener" "api_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port = 8000
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.api_tg.arn
    type = "forward"
  }
}