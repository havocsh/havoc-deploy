resource "aws_cloudwatch_log_group" "ecs_task_logs" {
  name = "${var.campaign_prefix}-${var.campaign_name}/ecs"
}

resource "aws_cloudwatch_log_subscription_filter" "task_result_lambdafunction_logfilter" {
  name            = "task_result_lambdafunction_logfilter"
  log_group_name  = aws_cloudwatch_log_group.ecs_task_logs.name
  filter_pattern  = "instruct_command_output user_id task_name"
  destination_arn = aws_lambda_function.task_result.arn
}