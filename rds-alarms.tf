data "aws_db_instance" "database" {
  db_instance_identifier = var.db_instance_id
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  count               = var.high_cpu_enabled ? 1 : 0
  alarm_name          = "${var.db_instance_id}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.high_cpu_threshold
  alarm_description   = "Average database CPU utilization IN ${var.db_instance_id} is too high"
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]
  datapoints_to_alarm = 5
  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })

}
resource "aws_cloudwatch_metric_alarm" "high_memory" {
  count               = var.high_memory_enabled ? 1 : 0
  alarm_name          = "${var.db_instance_id}-high-memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 5
  datapoints_to_alarm = 5
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.high_memory_capacity_gib * 1073741824 * (100 - var.high_memory_threshold) / 100
  alarm_description   = "Average database Memory utilization IN ${var.db_instance_id} is too high"
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })

}

resource "aws_cloudwatch_metric_alarm" "high_connections" {
  count               = var.high_connections_enabled ? 1 : 0
  alarm_name          = "${var.db_instance_id}_high_connections"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]
  threshold           = var.high_connections_max * var.high_connections_threshold / 100
  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })


  alarm_description = "Alarm database connections IN ${var.db_instance_id} is too high"
}

resource "aws_cloudwatch_metric_alarm" "high_storage" {
  count               = var.high_storage_enabled ? 1 : 0
  alarm_name          = "${var.db_instance_id}_high_storage"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeLocalStorage"
  namespace           = "AWS/RDS"
  period              = "600"
  statistic           = "Average"
  threshold           = data.aws_db_instance.database.allocated_storage * 1000000000 * (100 - var.high_storage_threshold) / 100
  alarm_description   = "Average database storage IN ${var.db_instance_id} is too high"
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })

}

resource "aws_cloudwatch_metric_alarm" "high_write_latency" {
  count               = var.high_write_latency_enabled ? 1 : 0
  alarm_name          = "${var.db_instance_id}_high_write_latency"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "WriteLatency"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = var.high_write_latency_seconds
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]
  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })


  alarm_description = "Write IOPS latency IN ${var.db_instance_id} is too high"

}

resource "aws_cloudwatch_metric_alarm" "high_read_latency" {
  count               = var.high_read_latency_enabled ? 1 : 0
  alarm_name          = "${var.db_instance_id}_high_read_latency"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ReadLatency"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = var.high_read_latency_seconds

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })



  alarm_description = "Read IOPS latency IN ${var.db_instance_id} is too high"
  alarm_actions     = [var.aws_sns_topic_arn]
  ok_actions        = [var.aws_sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "disk_queue_depth_too_high" {
  count               = var.disk_queue_depth_enabled ? 1 : 0
  alarm_name          = "${var.db_instance_id}_disk_queue_depth"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "DiskQueueDepth"
  namespace           = "AWS/RDS"
  period              = "600"
  statistic           = "Average"
  threshold           = var.disk_queue_depth_threshold
  alarm_description   = "Average database disk queue depth IN ${var.db_instance_id} is too high"
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]
  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })

}

resource "aws_cloudwatch_metric_alarm" "swap_usage_too_high" {
  count               = var.swap_usage_enabled ? 1 : 0
  alarm_name          = "${var.db_instance_id}_swap_usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "SwapUsage"
  namespace           = "AWS/RDS"
  period              = "600"
  statistic           = "Average"
  threshold           = var.swap_usage_threshold_bytes
  alarm_description   = "Average database swap usage IN ${var.db_instance_id} is too high"
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]
  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })

}
