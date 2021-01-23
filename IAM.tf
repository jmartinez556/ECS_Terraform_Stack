# Allows our tasks to assume a role
resource "aws_iam_role" "task-role" {
  name = "${var.app_name}-${var.region}-task-role"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Sid": "",
     "Effect": "Allow",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Action": "sts:AssumeRole"
   }
 ]
}
EOF
}
# What the task is allowed to : create logs
resource "aws_iam_policy" "task-policy" {
  name        = "${var.app_name}-${var.region}-task-policy"
  path        = "/"
  description = "My test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
# Allowing access to the ecs logs
resource "aws_iam_policy_attachment" "ecs-logs" {
  name       = "${var.app_name}-${var.region}-ecs-logs"
  roles      = [aws_iam_role.task-role.name]
  policy_arn = aws_iam_policy.task-policy.arn
}
# Allowing aws to launch tasks
resource "aws_iam_role" "task-execution-role" {
  name = "${var.app_name}-${var.region}-task-execution-role"


  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Sid": "",
     "Effect": "Allow",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Action": "sts:AssumeRole"
   }
 ]
}
EOF
}
# Allowing the ec2 to interact with ECS
resource "aws_iam_instance_profile" "test-profile" {
  name = "${var.app_name}-${var.region}-test-profile"
  role = aws_iam_role.ec2-role.name
}
# Giving the ec2 a role
resource "aws_iam_role" "ec2-role" {
  name = "${var.app_name}-${var.region}-ec2-role"
  path = "/"

  assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Action": "sts:AssumeRole",
           "Principal": {
              "Service": "ec2.amazonaws.com"
           },
           "Effect": "Allow",
           "Sid": ""
       }
   ]
}
EOF
}

resource "aws_iam_policy" "ec2-policy" {
  name        = "${var.app_name}-${var.region}-ec2-policy"
  path        = "/"
  description = "My test policy"

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DescribeTags",
          "ecs:CreateCluster",
          "ecs:DeregisterContainerInstance",
          "ecs:DiscoverPollEndpoint",
          "ecs:Poll",
          "ecs:RegisterContainerInstance",
          "ecs:StartTelemetrySession",
          "ecs:UpdateContainerInstancesState",
          "ecs:Submit*",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings",
          "ecr:CompleteLayerUpload",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "*"
      }
    ]
  }
  EOF
}
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ec2-role.name
  policy_arn = aws_iam_policy.ec2-policy.arn
}

resource "aws_iam_policy" "task-execution-policy" {
  name        = "${var.app_name}-${var.region}-task-execution-policy"
  path        = "/"
  description = "My test policy"

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroup",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings",
          "ecr:GetAuthorizationToken"
        ],
        "Resource": "*"
      }
    ]
  }
  EOF
}
resource "aws_iam_role_policy_attachment" "test-attach2" {
  role       = aws_iam_role.task-execution-role.name
  policy_arn = aws_iam_policy.task-execution-policy.arn
}


