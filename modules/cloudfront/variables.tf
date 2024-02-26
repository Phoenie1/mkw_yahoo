variable "arg" {}

variable "env" {
  type        = string
  default     = "put-name-of-your-env-here"
  description = "Name of the target environment"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region for Lambda@Edge deployment"
}
variable "domain" {
  type = string
}
variable "bucket_endpoint" {
  type        = "string"
}
