variable "bucket" {
  type        = string
  description = "Specifies the name of an S3 Bucket"
  default     = "dojoweather_sam_2022"
}

variable "tags" {
  type        = map(string)
  description = "Use tags to identify project resources"
  default     = {
    Owner = "Sam Bentley"
    Project = "Dojo Weather App"
  }
}