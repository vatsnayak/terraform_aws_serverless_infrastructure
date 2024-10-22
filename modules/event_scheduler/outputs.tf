output "schedule_rule_arn" {
  description = "The ARN of the CloudWatch EventBridge rule"
  value       = aws_cloudwatch_event_rule.lambda_schedule.arn
}