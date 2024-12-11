data "aws_db_instance" "database" {
  db_instance_identifier = var.db_instance_id
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  count               = var.high_cpu_enabled ? 1 : 0
  alarm_name          = "RDS | ${var.db_instance_id} | High CPU"
  alarm_description   = "High CPU utilization in ${var.db_instance_id}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.high_cpu_threshold
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
  alarm_name          = "RDS | ${var.db_instance_id} | High Memory"
  alarm_description   = "High Memory utilization in ${var.db_instance_id}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 5
  datapoints_to_alarm = 5
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.high_memory_capacity_gib * 1073741824 * (100 - var.high_memory_threshold) / 100
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
  alarm_name          = "RDS | ${var.db_instance_id} | High Connections"
  alarm_description   = "High connections in ${var.db_instance_id}"
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


}

resource "aws_cloudwatch_metric_alarm" "high_local_storage" {
  count               = var.high_storage_enabled ? 1 : 0
  alarm_name          = "RDS | ${var.db_instance_id} | High Local Storage"
  alarm_description   = "High Local Storage in ${var.db_instance_id}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeLocalStorage"
  namespace           = "AWS/RDS"
  period              = "600"
  statistic           = "Average"
  threshold           = data.aws_db_instance.database.allocated_storage * 1000000000 * (100 - var.high_local_storage_threshold) / 100
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

resource "aws_cloudwatch_metric_alarm" "high_storage_space" {
  count               = var.high_storage_enabled ? 1 : 0
  alarm_name          = "RDS | ${var.db_instance_id} | High Storage Space"
  alarm_description   = "High Storage Space in ${var.db_instance_id}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "600"
  statistic           = "Average"
  threshold           = data.aws_db_instance.database.allocated_storage * 1000000000 * (100 - var.high_storage_space_threshold) / 100
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
  alarm_name          = "RDS | ${var.db_instance_id} | High Write Latency"
  alarm_description = "High Write IOPS latency in ${var.db_instance_id}"
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



}

resource "aws_cloudwatch_metric_alarm" "high_read_latency" {
  count               = var.high_read_latency_enabled ? 1 : 0
  alarm_name          = "RDS | ${var.db_instance_id} | High Read Latency"
  alarm_description = "High Read IOPS latency in ${var.db_instance_id}"
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

  alarm_actions     = [var.aws_sns_topic_arn]
  ok_actions        = [var.aws_sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "disk_queue_depth_too_high" {
  count               = var.disk_queue_depth_enabled ? 1 : 0
  alarm_name          = "RDS | ${var.db_instance_id} | Disk Queue Depth"
  alarm_description   = "High Disk Queue Depth in ${var.db_instance_id}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "DiskQueueDepth"
  namespace           = "AWS/RDS"
  period              = "600"
  statistic           = "Average"
  threshold           = var.disk_queue_depth_threshold
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
  alarm_name          = "RDS | ${var.db_instance_id} | Swap Use"
  alarm_description   = "High Swap usage in ${var.db_instance_id}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "SwapUsage"
  namespace           = "AWS/RDS"
  period              = "600"
  statistic           = "Average"
  threshold           = (var.swap_usage_threshold / 100) * var.high_memory_capacity_gib * 1073741824
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
