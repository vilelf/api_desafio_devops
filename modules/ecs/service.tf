resource "aws_ecs_service" "service" {
  name = "api_desafio_devops"
  cluster = aws_ecs_cluster.api_cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count = 3
  launch_type = "FARGATE"

  load_balancer {
    container_name = "api_desafio_devops"
    container_port = 8000
  }
}