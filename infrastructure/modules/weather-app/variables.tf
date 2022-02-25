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

variable "public_subnet_ids" {
  description = "ID of the first public subne to deploy the ALB to"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "ID of the first public subne to deploy the ALB to"
  type        = list(string)
}

variable "image_id" {
  description = "URI of the Container Image stored in ECR "
  type = string
}