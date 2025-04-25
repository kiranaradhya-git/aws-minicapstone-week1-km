provider "aws" {
  region = var.aws_region
}

module "website_s3" {
  source = "./modules/s3_website"

  bucket_name                       = var.s3_bucket_name
  index_document                    = var.index_document
  error_document                    = var.error_document
  cloudfront_origin_access_control_arn = module.cloudfront.oac_arn
}

module "cloudfront" {
  source = "./modules/cloudfront_distribution"

  s3_bucket_regional_domain_name = "${module.website_s3.bucket_id}.s3.${var.aws_region}.amazonaws.com"
  index_document                 = var.index_document
  aliases                        = var.aliases
  acm_certificate_arn            = var.acm_certificate_arn
  price_class                    = var.cloudfront_price_class
  tags                           = var.tags
  oac_name                       = "website-oac-${var.s3_bucket_name}"
}

output "website_url" {
  value       = "https://${module.cloudfront.distribution_domain_name}"
  description = "The URL of the static website served via CloudFront."
}

output "s3_bucket_name" {
  value       = module.website_s3.bucket_id
  description = "The name of the S3 bucket."
}

output "cloudfront_distribution_id" {
  value       = module.cloudfront.distribution_id
  description = "The ID of the CloudFront distribution."
}