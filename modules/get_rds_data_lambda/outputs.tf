output "get_rds_data_lambda_arn" {
  description = "The ARN of the get_rds_data_lambda function"
  value       = aws_lambda_function.get_rds_data_lambda.arn
}
