terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "pathways-dojo"
    key    = "beardedsamwise-tfstate-main"
    region = "us-east-1"
  }
}