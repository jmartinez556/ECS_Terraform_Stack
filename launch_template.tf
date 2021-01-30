# Launch Configuration
resource "aws_launch_template" "as_conf2" {
  name          = "shared-${var.region}-as_conf2"
  image_id      = var.ami
  instance_type = var.instance_type
  network_interfaces {
    associate_public_ip_address = true
  }
  iam_instance_profile {
    arn = aws_iam_instance_profile.test-profile.arn
  }
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  user_data              = base64encode(local.user_data)
  key_name               = var.key_pair

  lifecycle {
    create_before_destroy = true
  }
}
# Telling the ec2 about ECS
locals {
  user_data = <<EOF
 #! /bin/bash
 echo "ECS_CLUSTER=${var.region}-cluster" >> /etc/ecs/ecs.config
EOF
}
