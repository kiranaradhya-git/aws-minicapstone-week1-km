variable "s3_bucket_regional_domain_name" {
  type        = string
  description = "The regional domain name of the S3 bucket (e.g., my-bucket.s3.us-east-1.amazonaws.com)."
}

variable "index_document" {
  type        = string
  description = "The object key name to use as the default root object."
  default     = "index.html"
}

variable "aliases" {
  type        = list(string)
  description = "A list of CNAMEs (alternate domain names) for the distribution."
  default     = []
}

variable "acm_certificate_arn" {
  type        = string
  description = "The ARN of the ACM certificate to use for HTTPS."
}

variable "price_class" {
  type        = string
  description = "The price class for the CloudFront distribution (e.g., PriceClass_100)."
  default     = "PriceClass_100"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to the CloudFront distribution."
  default     = {}
}

variable "oac_name" {
  type        = string
  description = "The name for the CloudFront Origin Access Control."
}