resource "aws_cloudwatch_log_group" "monitoring" {
  name              = "/ecs/teste"
  retention_in_days = "14"
}