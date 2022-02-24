variable "prefix" {
  description = "Prefix applied to all resources as tag:Name"
  type = string
}

variable "git_username" {
  description = "Name of the deployed ECR repo"
  type = string
}

variable "vpc_id" {
  description = "ID of the VPC to deploy resources to"
  type = string
}

variable "public_subnet_id_0" {
  description = "ID of the first public subne to deploy the ALB to"
  type = string  
}

variable "public_subnet_id_1" {
  description = "ID of the second public subne to deploy the ALB to"
  type = string  
}

variable "logging_bucket" {
  description = "Bucket to send ALB access logs to"
  type = string
}