terraform {
  required_version = ">= 0.13.0"
  backend "s3" {
    bucket = "pathways-dojo"
    key    = "beardedsamwise-tfstate-main"
    region = "ap-northeast-1"
  }
}