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
  description = "Name of the Github user where the CI/CD workflow is running"
  type        = string
}

variable "image_id" {
  description = "URI of the Container Image stored in ECR "
  type        = string
}

variable "app_name" {
  description = "Name of the application that is being deployed"
  type        = string
}

variable "container_port" {
  description = "Port that the container application is listening on"
  type        = number
}

variable "task_cpu" {
  description = "The hard limit of CPU units to present to the ECS task"
  type        = number
}

variable "task_mem" {
  description = "The hard limit of memory units to present to the ECS task"
  type        = number
}

variable "desired_count" {
  description = "The desired number of container instances to instantiate"
  type        = number
}

variable "domain" {
  description = "Top level domain to create the DNS record in"
  type        = string
}