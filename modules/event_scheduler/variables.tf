variable "schedule_expression" {
  description = "Frequency of the event rule (e.g. rate(5 minutes))"
}

variable "lambda_arn" {
  description = "The ARN of the Lambda function to trigger"
}