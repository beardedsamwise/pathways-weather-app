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