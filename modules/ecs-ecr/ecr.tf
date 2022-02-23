### variables

variable "prefix" {
  description = "Prefix applied to all resources as tag:Name"
  type = string
}

variable "ecr_name" {
  description = "Name of the deployed ECR repo"
  type = string
}

### deploy ECR infrastructure

# deploy ECR instance
resource "aws_ecr_repository" "ecr" {
  name                 = var.ecr_name
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}