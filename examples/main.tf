provider "aws" {
  region = "eu-west-1"
}

resource "aws_sns_topic" "opsgenie_topic" {
  name         = "opsgenie"
  display_name = "opsgenie"
}

resource "aws_sns_topic_subscription" "opsgenie_subscription" {
  confirmation_timeout_in_minutes = 1
  endpoint_auto_confirms          = false
  topic_arn                       = aws_sns_topic.opsgenie_topic.arn
  protocol                        = "https"
  endpoint                        = "https://api.opsgenie.com/v1/xxx"
  depends_on = [ aws_sns_topic.opsgenie_topic ]
}

module "test-aurora-1-alarms" {
  source                           = "../"
  db_instance_id                   = "test-aurora-1"
  aws_sns_topic_arn                = aws_sns_topic.opsgenie_topic.arn
  high_connections_max_connections = 1365
  high_memory_max_allocations      = 16
  depends_on = [ aws_sns_topic.opsgenie_topic ]
}




