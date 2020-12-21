# Allows our tasks to assume a role
resource "aws_iam_role" "task_role" {
  name = "task_role"

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
resource "aws_iam_policy" "task_policy" {
  name        = "test_policy"
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
resource "aws_iam_policy_attachment" "test-attach" {
  name       = "task-attachment"
  roles      = [aws_iam_role.task_role.name]
  policy_arn = aws_iam_policy.task_policy.arn
}
# Allowing aws to launch tasks
resource "aws_iam_role" "task_execution_role" {
  name = "task_execution_role"

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
resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.ec2-role.name
}
# Giving the ec2 a role
resource "aws_iam_role" "ec2-role" {
  name = "ec2-role"
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

resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2_policy"
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
  policy_arn = aws_iam_policy.ec2_policy.arn
}

resource "aws_iam_policy" "task_execution_policy" {
  name        = "task_execution_policy"
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
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.task_execution_policy.arn
}


