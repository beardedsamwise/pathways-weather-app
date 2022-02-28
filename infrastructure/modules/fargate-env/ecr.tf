# deploy ECR instance
resource "aws_ecr_repository" "ecr" {
  name                 = "${var.git_username}-node-${var.app_name}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

