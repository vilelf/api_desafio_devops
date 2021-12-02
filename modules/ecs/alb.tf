resource "aws_alb" "alb" {
  name = "api-desafio-devops"
  security_groups = [aws_security_group.lb.id]

  subnets = [
    aws_default_subnet.default_az1.id, 
    aws_default_subnet.default_az2.id
  ]
}

resource "aws_lb_target_group" "api_tg" {
  name = "api-desafio-devops"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_default_vpc.default.id
  target_type = "ip"

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_lb_listener" "api_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.api_tg.arn
    type = "forward"
  }
}