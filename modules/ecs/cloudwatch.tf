resource "aws_cloudwatch_log_group" "monitoramento" {
  name              = "cloudwatch-teste"
  retention_in_days = "14"
}