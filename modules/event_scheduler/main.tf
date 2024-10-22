resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  name                = "lambda_schedule"
  schedule_expression = var.schedule_expression

  tags = {
    Terraform = "TRUE"
    EventType = "Scheduled"
  }
}

resource "aws_cloudwatch_event_target" "lambda_event_target" {
  rule      = aws_cloudwatch_event_rule.lambda_schedule.name
  target_id = "lambda_trigger"
  arn       = var.lambda_arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_schedule.arn
}
