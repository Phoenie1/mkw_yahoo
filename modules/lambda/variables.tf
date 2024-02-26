variable "lambda_file" {
  description = "File for lambda function"
}
variable "lambda_function_name" {
  description = "lambda function name"
}
variable "lambda_handler" {
  description = "lambda handler"
}
variable "lambda_iam_role" {
  description = "Lambda Function IAM Role Name"
}
variable "bucket" {
  description = "S3 bucket"
}
variable "bucket_arn" {
  description = "S3 bucket arn"
}
variable "kms_arn" {
  description = "KMS key arn"
}

