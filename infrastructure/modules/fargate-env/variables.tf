variable "prefix" {
  description = "Prefix applied to all resources for identification"
  type = string
}

variable "git_username" {
  description = "Name of the Github user where the CI/CI workflow is running"
  type = string
}

variable "vpc_id" {
  description = "ID of the VPC to deploy resources to"
  type = string
}

variable "public_subnet_ids" {
  description = "IDs of the public subnets to deploy the ALB to"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "ID of the private subnets to deploy the application to"
  type        = list(string)
}

variable "image_id" {
  description = "URI of the Container Image stored in ECR "
  type = string
}

variable "app_name" {
  description = "Name of the application that is being deployed"
  type = string
}

variable "container_port" {
  description = "Port that the container application is listening on"
  type = number
}

variable "task_cpu" {
  description = "The hard limit of CPU units to present to the ECS task"
  type = number
}

variable "task_mem" {
  description = "The hard limit of memory units to present to the ECS task"
  type = number
}
