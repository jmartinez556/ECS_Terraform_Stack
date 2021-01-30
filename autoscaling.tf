resource "aws_autoscaling_group" "bar" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = [aws_subnet.public-1.id, aws_subnet.public-2.id, aws_subnet.public-3.id]
  // target_group_arns   = [aws_lb_target_group.target_group.arn, aws_lb_target_group.target_group2.arn]



  launch_template {
    id      = aws_launch_template.as_conf2.id
    version = "$Latest"

  }
}
