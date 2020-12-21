resource "aws_lb" "alb" {
  internal           = "false"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer_sg.id]
  subnets            = [aws_subnet.public-1.id, aws_subnet.public-2.id]


  tags = {
    Deployment_Method = "Terraform"
  }
}

resource "aws_lb_listener" "port-80-traffic" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_listener_rule" "port-80-rule" {
  listener_arn = aws_lb_listener.port-80-traffic.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  condition {
    host_header {
      values = [var.domain]
    }
  }
}
