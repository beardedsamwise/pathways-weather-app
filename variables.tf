variable "bucket" {
  type        = string
  description = "Specifies the name of an S3 Bucket"
  default     = "dojostudent"
}

variable "prefix" {
  type        = string
  description = "prefix for resource identification"
  default     = "dojostudent"
}

variable "tags" {
  type        = map(string)
  description = "Use tags to identify project resources"
  default = {
    Owner   = "Sam Bentley"
    Project = "Dojo Weather App"
  }
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