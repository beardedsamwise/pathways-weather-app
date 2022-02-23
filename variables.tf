variable "bucket" {
  type        = string
  description = "Specifies the name of an S3 Bucket"
}

variable "prefix" {
  type        = string
  description = "Prefix applied to all resources as tag:Name"
}

variable "tags" {
  type        = map(string)
  description = "Tags to identify project resources"
}

variable "az" {
  description = "List of availability zones to deploy subnets to"
  type        = list(string)
}

variable "subnets_public" {
  description = "Object list of public subnets for deployment"
  type = list(object({
    name = string
    cidr = string
  }))
}

variable "subnets_private" {
  description = "Object list of private subnets for deployment"
  type = list(object({
    name = string
    cidr = string
  }))
}

variable "vpc_cidr" {
  description = "String representing the CIDR of the VPC CIDR block"
  type        = string
}

variable "git_username" {
  description = "Name of the deployed ECR repo"
  type        = string
}
