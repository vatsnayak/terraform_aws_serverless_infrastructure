# Output for api_lambda ARN
output "api_lambda_arn" {
  description = "The ARN of the api_lambda function"
  value       = module.api_lambda.api_lambda_arn
}

# Output for get_rds_data_lambda ARN
output "get_rds_data_lambda_arn" {
  description = "The ARN of the get_rds_data_lambda function"
  value       = module.get_rds_data_lambda.get_rds_data_lambda_arn
}

# Output for API Gateway URL
output "api_gateway_url" {
  description = "HTTP API Gateway URL"
  value       = module.api_gateway.http_api_url # Correct reference to module output
}

# Output for RDS endpoint
output "rds_endpoint" {
  description = "The endpoint of the RDS MySQL instance"
  value       = module.rds.db_endpoint
}

# Output for EventBridge rule ARN
output "event_rule_arn" {
  description = "The ARN of the CloudWatch EventBridge rule for Lambda"
  value       = module.event_scheduler.schedule_rule_arn
}
