variable "aws_region" {
  description = "AWS region where the resources are deployed"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function that the API Gateway will invoke"
  type        = string
}