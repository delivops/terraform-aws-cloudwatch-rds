provider "aws" {
  region = "eu-west-1"
}

resource "aws_sns_topic" "sns_topic" {
  name         = "sns"
  display_name = "sns"
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  confirmation_timeout_in_minutes = 1
  endpoint_auto_confirms          = false
  topic_arn                       = aws_sns_topic.sns_topic.arn
  protocol                        = "https"
  endpoint                        = "https://api.sns.com/v1/xxx"
  depends_on                      = [aws_sns_topic.sns_topic]
}

module "rds_alarms" {
  source = "delivops/cloudwatch-rds/aws"
  #version            = "0.0.5"

  db_instance_id           = "rds-aurora-1"
  aws_sns_topics_arns      = [aws_sns_topic.sns_topic.arn]
  high_connections_max     = 1365
  high_memory_capacity_gib = 16
  depends_on               = [aws_sns_topic.sns_topic]
}




