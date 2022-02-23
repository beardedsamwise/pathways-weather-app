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