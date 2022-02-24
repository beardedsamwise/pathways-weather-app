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

# create ECR, ECS and ALB instances to deploy weather-app
module "weather-app" {
  source             = "./modules/weather-app"
  prefix             = var.prefix
  git_username       = var.git_username
  vpc_id             = module.vpc.vpc_id
  public_subnet_id_0 = module.vpc.public_subnet_id_0
  public_subnet_id_1 = module.vpc.public_subnet_id_1
  logging_bucket     = module.s3_bucket.s3_bucket_name
}

