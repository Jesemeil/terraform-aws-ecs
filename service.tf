resource "aws_ecs_service" "systest_service" {
  name            = "systest-service"
  cluster         = aws_ecs_cluster.systest_cluster.id
  task_definition = aws_ecs_task_definition.systest_task_definition.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.systest_subnets[*].id
    security_groups = [aws_security_group.systest_task_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.systest_target_group.arn
    container_name   = "systest-container"
    container_port   = 80
  }

  tags = {
    Environment = "systest"
  }
}














