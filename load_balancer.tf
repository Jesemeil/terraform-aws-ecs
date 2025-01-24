resource "aws_lb" "systest_alb" {
  name               = "systest-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.systest_alb_sg.id]
  subnets            = aws_subnet.systest_subnets[*].id

  tags = {
    Environment = "systest"
  }
}

resource "aws_lb_listener" "systest_listener" {
  load_balancer_arn = aws_lb.systest_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.systest_target_group.arn
  }
}

resource "aws_lb_target_group" "systest_target_group" {
  name        = "systest-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.systest_vpc.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Environment = "systest"
  }
}
















