variable "lambda_file" {
  description = "File for lambda function"
  type        = string
}
variable "lambda_function_name" {
  description = "lambda function name"
  type        = string
}
variable "lambda_handler" {
  description = "lambda handler"
  type        = string
}
variable "lambda_iam_role" {
  description = "Lambda Function IAM Role"
  type        = string
}
variable "bucket" {
  description = "Name of the bucket."
  type        = string
}
variable "force_destroy" {
  description = "Boolean that indicates all objects should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error."
  type        = bool
  default     = false
}
variable "tags" {
  description = "Map of tags to assign to the bucket."
  type        = map(any)
  default = {

  }
}
variable "versioning_status" {
  description = "Versioning state of the bucket."
  type        = string
  default     = "Disabled"
}
variable "object_ownership" {
  description = "Versioning state of the bucket."
  type        = string
  default     = "BucketOwnerEnforced"
}
variable "event_name" {
  description = "Name of eventbridge event"
  type        = string
}
variable "schedule_expression" {
  description = "Expression for how often to fire the event"
  type        = string
  default     = "rate(10 minutes)"
}
variable "lambdaatedge_name" {
  type        = string
}
