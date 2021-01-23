
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
resource "aws_autoscaling_group" "bar" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = [aws_subnet.private-1.id]
  //  target_group_arns   = [aws_lb_target_group.target_group.arn]



  launch_configuration = aws_launch_configuration.as_conf.name
}
