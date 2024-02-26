variable "event_name" {
  description = "Name of eventbridge event"
  type        = string
}
variable "schedule_expression" {
  description = "Expression for how often to fire the event"
  type        = string
  default     = "rate(10 minutes)"
}
variable "lambda_function_name" {
  description = "lambda function name"
  type        = string
}
variable "lambda_arn" {
  description = "lambda function arn"
  type        = string
}
