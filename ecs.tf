# ECS SERVICE
# THIS SERVICE MANAGES THE ECS SERVICE AND TASKS
resource "aws_ecs_service" "ecs-service" {
  name            = "${var.app_name}-${var.region}-ecs-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 3
  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.capacity-provider.id
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
  tags = {
    name = "${var.app_name}-${var.region}-ecs-service"
  }
}
# ECS CLUSTER
resource "aws_ecs_cluster" "cluster" {
  name               = "${var.app_name}-${var.region}-cluster"
  capacity_providers = [aws_ecs_capacity_provider.capacity-provider.name]
  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.capacity-provider.name
    weight            = 1
  }
  tags = {
    name = "${var.app_name}-${var.region}-cluster"
  }
}
# Capacity provider
resource "aws_ecs_capacity_provider" "capacity-provider" {
  name = "${var.app_name}-${var.region}-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.bar.arn

    managed_scaling {
      maximum_scaling_step_size = 1
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 1
    }
  }
  tags = {
    name = "${var.app_name}-${var.region}-capacity-provider"
  }
}
# ECS tasks definition/container definition
resource "aws_ecs_task_definition" "service" {
  family             = "service"
  task_role_arn      = aws_iam_role.task-role.arn
  execution_role_arn = aws_iam_role.task-execution-role.arn
  network_mode       = "awsvpc"

  container_definitions = <<EOF
[{
        "name": "${var.container_name}",
        "image": "${var.container_image}",
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
 echo "ECS_CLUSTER=white-hart" >> /etc/ecs/ecs.config
EOF
}
