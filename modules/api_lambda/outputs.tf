output "api_lambda_arn" {
  description = "The ARN of the api_lambda function"
  value       = aws_lambda_function.api_lambda.arn
}
