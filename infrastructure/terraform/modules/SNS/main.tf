resource "aws_sns_topic" "glue_job_status_change" {
  name = "glue-job-status-change"
}
