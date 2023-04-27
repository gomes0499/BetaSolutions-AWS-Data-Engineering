variable "glue_job_states" {
  description = "A list of Glue Job states to monitor"
  type        = list(string)
  default     = ["SUCCEEDED", "FAILED", "STOPPED", "TIMEOUT"]
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS Topic to send notifications"
  type        = string
}

variable "glue_job_name" {
  description = "The name of the Glue Job to monitor"
  type        = string
}