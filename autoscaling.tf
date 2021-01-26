resource "aws_autoscaling_group" "bar" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = [aws_subnet.private-1.id, aws_subnet.private-2.id, aws_subnet.private-3.id]
  //  target_group_arns   = [aws_lb_target_group.target_group.arn]



  launch_configuration = aws_launch_configuration.as_conf.name
}
