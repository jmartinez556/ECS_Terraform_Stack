# TARGET GROUP
resource "aws_lb_target_group" "target_group" {
  name        = "${var.app_name}-${var.region}-target-group"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"
  depends_on  = [aws_lb.alb]
  tags = {
    name = "${var.app_name}-${var.region}-target-group"
  }

  health_check {
    enabled           = true
    matcher           = "200-304"
    protocol          = "HTTP"
    path              = "/"
    timeout           = 30
    interval          = 31
    healthy_threshold = 2
  }
}
# TARGET GROUP
resource "aws_lb_target_group" "target_group2" {
  name        = "${var.app_name2}-${var.region}-target-group"
  port        = var.container_port2
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"
  depends_on  = [aws_lb.alb]
  tags = {
    name = "${var.app_name2}-${var.region}-target-group"
  }

  health_check {
    enabled           = true
    matcher           = "200-304"
    protocol          = "HTTP"
    path              = "/"
    timeout           = 30
    interval          = 31
    healthy_threshold = 2
  }
}