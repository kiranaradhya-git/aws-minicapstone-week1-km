output "bucket_id" {
  value       = aws_s3_bucket.website_bucket.id
  description = "The ID of the S3 bucket."
}

output "bucket_arn" {
  value       = aws_s3_bucket.website_bucket.arn
  description = "The ARN of the S3 bucket."
}

output "website_endpoint" {
  value       = aws_s3_bucket.website_bucket.website_endpoint
  description = "The website endpoint of the S3 bucket (if public access was enabled directly)."
}