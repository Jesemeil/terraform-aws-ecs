resource "aws_ecs_task_definition" "systest_task_definition" {
  family                   = "systest-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256" # 0.25 vCPU
  memory                   = "512" # 512MB

  container_definitions = jsonencode([
    {
      name      = "systest-container"
      image     = "${aws_ecr_repository.systest_repo.repository_url}:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/systest"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn

  tags = {
    Environment = "systest"
  }
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/systest"
  retention_in_days = 7

  tags = {
    Environment = "systest"
  }
}


