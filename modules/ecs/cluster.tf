resource "aws_ecs_cluster" "api_cluster" {
  name = "api-cluster-${var.environment}"

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"
      log_configuration {
        cloud_watch_log_group_name = aws_cloudwatch_log_group.monitoring.name
      }
    }
  }
  tags = {
    Name = "terraform-test-${var.environment}"
  }
}