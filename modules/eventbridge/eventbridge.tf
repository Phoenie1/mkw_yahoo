resource "aws_cloudwatch_event_rule" "fire_lambda_event" {
    name                = var.event_name
    schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "fire_lambda_on_schedule" {
    rule                = "${aws_cloudwatch_event_rule.fire_lambda_event.name}"
    target_id           = "lambda"
    arn                 = var.lambda_arn
}

resource "aws_lambda_permission" "allow_cloudwatch_scheduled_exec" {
    statement_id        = "AllowExecutionFromCloudWatch"
    action              = "lambda:InvokeFunction"
    function_name       = var.lambda_function_name
    principal           = "events.amazonaws.com"
    source_arn          = "${aws_cloudwatch_event_rule.fire_lambda_event.arn}"
}

