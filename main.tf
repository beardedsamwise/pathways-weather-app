# create S3 bucket
module "s3_bucket" {
  source = "./modules/s3"
  bucket = var.bucket
}

output "bucket_name" {
  description = "The name of the bucket"
  value       = ["${module.s3_bucket.s3_bucket_name}"]
}

output "bucket_name_arn" {
  description = "The name of the bucket"
  value       = ["${module.s3_bucket.s3_bucket_name_arn}"]
}

# create VPC, subnets, NAT GWs, Internet GWs, route tables and S3 endpoint
module "vpc" {
  source          = "./modules/vpc"
  prefix          = var.prefix
  subnets_public  = var.subnets_public
  subnets_private = var.subnets_private
  az              = var.az
  vpc_cidr        = var.vpc_cidr
}

# create ECR and ECS instances
module "ecs-ecr" {
  source   = "./modules/ecs-ecr"
  prefix   = var.prefix
  ecr_name = var.ecr_name
}