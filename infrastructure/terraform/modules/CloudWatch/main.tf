resource "aws_cloudwatch_event_rule" "glue_job_status_change" {
  name        = "glue-job-status-change"
  description = "Capture Glue Job status changes"

  event_pattern = jsonencode({
    "source" : ["aws.glue"],
    "detail-type" : ["Glue Job State Change"],
    "detail" : {
      "jobName" : [var.glue_job_name],
      "state" : var.glue_job_states
    }
  })
}

resource "aws_cloudwatch_event_target" "glue_job_status_change_target" {
  rule      = aws_cloudwatch_event_rule.glue_job_status_change.name
  target_id = "SendToSNS"
  arn       = var.sns_topic_arn
}

resource "aws_sns_topic_policy" "default" {
  arn = var.sns_topic_arn

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "default"
    Statement = [
      {
        Sid    = "AllowCloudWatchToSendMessage"
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
        Action   = "sns:Publish"
        Resource = var.sns_topic_arn
      }
    ]
  })
}
