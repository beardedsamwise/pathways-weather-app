### variables

variable "prefix" {
  description = "Prefix applied to all resources as tag:Name"
  type = string
}

variable "git_username" {
  description = "Name of the deployed ECR repo"
  type = string
}

### deploy ECR infrastructure

# deploy ECR instance
resource "aws_ecr_repository" "ecr" {
  name                 = "${var.git_username}-node-weather-app"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# create IAM policy to allow ECS to pull images from the ECR repo
resource "aws_iam_policy" "ecs" {
  name        = "${var.git_username}EcsEcrAccess"
  path        = "/"
  description = "ECS exection policy (allows ECS to pull images from ECR)"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:BatchCheckLayerAvailability",
                "ecr:BatchGetImage",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetAuthorizationToken"
            ],
            "Resource": "*"
        }
    ]
    })
}

# create IAM role to allow ECS to pull images from the ECR repo
resource "aws_iam_role" "ecs" {
  name = "${var.git_username}EcsExecutionRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "ecs-tasks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
  })
}

# attach IAM policy to IAM role
resource "aws_iam_role_policy_attachment" "ecs" {
  role       = aws_iam_role.ecs.name
  policy_arn = aws_iam_policy.ecs.arn
}