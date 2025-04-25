aws_region          = "us-est-1" # Choose your desired region
s3_bucket_name      = "kmuddaiah-unique-static-website-bucket-20250425" # Replace with a globally unique name
acm_certificate_arn = "arn:aws:acm:ap-south-1:123456789012:certificate/your-certific-dar # Replace with your ACM certificate ARN
aliases             = ["www.mydomain.com", "mydomain.com"] # Replace with your domain names
tags = {
  Environment = "Production"
  Project     = "StaticWebsite"
  ManagedBy   = "Terraform"
}