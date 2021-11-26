resource "aws_ecs_cluster" "api_cluster" {
  name = "api-cluster-${var.environment}"

  tags = {
    Name = "terraform-test-${var.environment}"
  }
}