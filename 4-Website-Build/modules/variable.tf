variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket for the website."
}

variable "index_document" {
  type        = string
  description = "The object key name to use as the index document."
  default     = "index.html"
}

variable "error_document" {
  type        = string
  description = "The object key name to use as the error document."
  default     = "error.html"
}

variable "cloudfront_origin_access_control_arn" {
  type        = string
  description = "The ARN of the CloudFront Origin Access Control."
}