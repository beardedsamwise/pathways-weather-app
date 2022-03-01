### GENERATE OUTPUTS

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = ["${module.s3_bucket.s3_bucket_name}"]
}

output "bucket_name_arn" {
  description = "ARN of the S3 bucket"
  value       = ["${module.s3_bucket.s3_bucket_name_arn}"]
}

output "alb_fqdn" {
  description = "FQDN of the ALB"
  value       = ["${module.weather-app.alb_fqdn}"]
}