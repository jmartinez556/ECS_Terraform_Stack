# Launch Configuration
resource "aws_launch_configuration" "as_conf" {
  name                        = "${var.app_name}-${var.region}-as_conf"
  image_id                    = var.ami
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.test-profile.arn
  security_groups             = [aws_security_group.ec2_security_group.id]
  associate_public_ip_address = true
  user_data                   = base64encode(local.user_data)

  lifecycle {
    create_before_destroy = true
  }
}
# Telling the ec2 about ECS
locals {
  user_data = <<EOF
 #! /bin/bash
 echo "ECS_CLUSTER=${var.app_name}-${var.region}-cluster" >> /etc/ecs/ecs.config
EOF
}
