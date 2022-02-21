### Define Variables
variable "bucket" {
  default     = ""
}

### Create Resources
resource "aws_s3_bucket" "this" {
  bucket = var.bucket
  acl    = "private"
  server_side_encryption_configuration {
    rule {
      #bucket_key_enabled = true
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
            }
        }
  }
}

### Define Output
output "s3_bucket_name" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.this.id
}

output "s3_bucket_name_arn" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.this.arn
}