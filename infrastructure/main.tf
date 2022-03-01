### CREATE RESOURCES

# create S3 bucket
module "s3_bucket" {
  source = "./modules/s3"
  bucket = var.bucket
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

# create ECR, ECS and ALB instances to deploy weather-app to Fargate
module "weather-app" {
  source             = "./modules/fargate-env"
  prefix             = var.prefix
  git_username       = var.git_username
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  image_id           = var.image_id
  app_name           = var.app_name
  container_port     = var.container_port
  task_mem           = var.task_mem
  task_cpu           = var.task_cpu
}