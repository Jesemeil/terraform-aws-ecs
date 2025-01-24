provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "systest_alb_sg" {
  name        = "systest-alb-sg"
  description = "Security group for the load balancer"
  vpc_id      = aws_vpc.systest_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "systest"
  }
}

resource "aws_security_group" "systest_task_sg" {
  name        = "systest-task-sg"
  description = "Security group for ECS tasks"
  vpc_id      = aws_vpc.systest_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [
      aws_security_group.systest_alb_sg.id,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "systest"
  }
}






