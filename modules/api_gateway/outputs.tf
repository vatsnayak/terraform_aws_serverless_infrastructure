output "http_api_url" {
  description = "HTTP API Gateway invoke URL"
  value       = aws_apigatewayv2_stage.api_stage.invoke_url  # Correct reference for HTTP API
}
