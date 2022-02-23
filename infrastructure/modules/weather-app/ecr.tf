# deploy ECR instance
resource "aws_ecr_repository" "ecr" {
  name                 = "${var.git_username}-node-weather-app"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

