# ECS service
# This service manages the ECS cluster and tasks
resource "aws_ecs_service" "mango" {
  name            = "mangodb"
  cluster         = aws_ecs_cluster.cake.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 3
  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.test.id
    weight            = 1
  }
  network_configuration {
    subnets         = [aws_subnet.private-1.id]
    security_groups = [aws_security_group.ECS_security_sg.id]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}
# ECS cluster
resource "aws_ecs_cluster" "cake" {
  name               = "white-hart"
  capacity_providers = [aws_ecs_capacity_provider.test.name]
  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.test.name
    weight            = 1
  }
}
# Capacity provider
resource "aws_ecs_capacity_provider" "test" {
  name = "test"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.bar.arn

    managed_scaling {
      maximum_scaling_step_size = 2
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 1
    }
  }
}
# ECS tasks definition
resource "aws_ecs_task_definition" "service" {
  family             = "service"
  task_role_arn      = aws_iam_role.task_role.arn
  execution_role_arn = aws_iam_role.task_execution_role.arn
  network_mode       = "awsvpc"

  container_definitions = <<EOF
[{
        "name": "${var.container_name}",
        "image": "054642084504.dkr.ecr.us-east-1.amazonaws.com/monday_before_christmas",
        "memory": 756,
        "essential": true,
        "portMappings": [
          {
            "containerPort": ${var.container_port}
         }
       ],
        "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-region": "us-east-1",
          "awslogs-group": "MYLOGGROUP"
        }
      }
}]
EOF
}
# Launch Configuration
resource "aws_launch_configuration" "as_conf" {
  name_prefix                 = "terraform-lc-example-"
  image_id                    = var.ami
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.test_profile.arn
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
 echo "ECS_CLUSTER=white-hart" >> /etc/ecs/ecs.config
EOF
}
