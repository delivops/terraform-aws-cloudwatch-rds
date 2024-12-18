data "aws_db_instance" "database" {
  db_instance_identifier = var.db_instance_id
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  count                     = var.high_cpu_enabled ? 1 : 0
  alarm_name                = "RDS| High CPU Utilization (>${var.high_cpu_threshold}%) | ${var.db_instance_id} "
  alarm_description         = "High CPU utilization in ${var.db_instance_id}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  period                    = 300
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  statistic                 = "Average"
  threshold                 = var.high_cpu_threshold
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.high_cpu_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.high_cpu_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.high_cpu_sns_arns)

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })
}

resource "aws_cloudwatch_metric_alarm" "high_memory" {
  count                     = var.high_memory_enabled ? 1 : 0
  alarm_name                = "RDS | High Memory Utilization (>${var.high_memory_threshold}%) | ${var.db_instance_id}"
  alarm_description         = "High Memory utilization in ${var.db_instance_id}"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  period                    = 300
  metric_name               = "FreeableMemory"
  namespace                 = "AWS/RDS"
  statistic                 = "Average"
  threshold                 = var.high_memory_capacity_gib * 1073741824 * (100 - var.high_memory_threshold) / 100
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.high_memory_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.high_memory_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.high_memory_sns_arns)

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })
}

resource "aws_cloudwatch_metric_alarm" "high_connections" {
  count                     = var.high_connections_enabled ? 1 : 0
  alarm_name                = "RDS | High Connections (>${var.high_connections_threshold}%) | ${var.db_instance_id}"
  alarm_description         = "High connections in ${var.db_instance_id}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  period                    = 300
  metric_name               = "DatabaseConnections"
  namespace                 = "AWS/RDS"
  statistic                 = "Average"
  threshold                 = var.high_connections_max * var.high_connections_threshold / 100
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.high_connections_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.high_connections_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.high_connections_sns_arns)

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })
}

resource "aws_cloudwatch_metric_alarm" "high_local_storage" {
  count                     = var.high_local_storage_enabled ? 1 : 0
  alarm_name                = "RDS | High Local Storage (>${var.high_local_storage_threshold}%) | ${var.db_instance_id}"
  alarm_description         = "High Local Storage in ${var.db_instance_id}"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  period                    = 300
  metric_name               = "FreeLocalStorage"
  namespace                 = "AWS/RDS"
  statistic                 = "Average"
  threshold                 = data.aws_db_instance.database.allocated_storage * 1000000000 * (100 - var.high_local_storage_threshold) / 100
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.high_local_storage_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.high_local_storage_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.high_local_storage_sns_arns)

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })
}

resource "aws_cloudwatch_metric_alarm" "high_storage_space" {
  count                     = var.high_storage_space_enabled ? 1 : 0
  alarm_name                = "RDS | High Storage Space (>${var.high_storage_space_threshold}%) | ${var.db_instance_id}"
  alarm_description         = "High Storage Space in ${var.db_instance_id}"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  period                    = 300
  metric_name               = "FreeStorageSpace"
  namespace                 = "AWS/RDS"
  statistic                 = "Average"
  threshold                 = data.aws_db_instance.database.allocated_storage * 1000000000 * (100 - var.high_storage_space_threshold) / 100
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.high_storage_space_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.high_storage_space_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.high_storage_space_sns_arns)
  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })
}

resource "aws_cloudwatch_metric_alarm" "high_write_latency" {
  count                     = var.high_write_latency_enabled ? 1 : 0
  alarm_name                = "RDS | High Write Latency (>${var.high_write_latency_seconds}s) | ${var.db_instance_id}"
  alarm_description         = "High Write IOPS latency in ${var.db_instance_id}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  period                    = 300
  metric_name               = "WriteLatency"
  namespace                 = "AWS/RDS"
  statistic                 = "Maximum"
  threshold                 = var.high_write_latency_seconds
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.high_write_latency_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.high_write_latency_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.high_write_latency_sns_arns)

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })
}

resource "aws_cloudwatch_metric_alarm" "high_read_latency" {
  count                     = var.high_read_latency_enabled ? 1 : 0
  alarm_name                = "RDS | High Read Latency (>${var.high_read_latency_seconds}s) | ${var.db_instance_id}"
  alarm_description         = "High Read IOPS latency in ${var.db_instance_id}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  period                    = 300
  metric_name               = "ReadLatency"
  namespace                 = "AWS/RDS"
  statistic                 = "Maximum"
  threshold                 = var.high_read_latency_seconds
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.high_read_latency_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.high_read_latency_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.high_read_latency_sns_arns)

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })
}

resource "aws_cloudwatch_metric_alarm" "disk_queue_depth_too_high" {
  count                     = var.disk_queue_depth_enabled ? 1 : 0
  alarm_name                = "RDS | Disk Queue Depth (>${var.disk_queue_depth_threshold}) | ${var.db_instance_id}"
  alarm_description         = "High Disk Queue Depth in ${var.db_instance_id}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  period                    = 300
  metric_name               = "DiskQueueDepth"
  namespace                 = "AWS/RDS"
  statistic                 = "Average"
  threshold                 = var.disk_queue_depth_threshold
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.disk_queue_depth_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.disk_queue_depth_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.disk_queue_depth_sns_arns)

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })
}

resource "aws_cloudwatch_metric_alarm" "swap_usage_too_high" {
  count                     = var.swap_usage_enabled ? 1 : 0
  alarm_name                = "RDS | Swap Use (>${var.swap_usage_threshold}%) | ${var.db_instance_id}"
  alarm_description         = "High Swap usage in ${var.db_instance_id}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  period                    = 300
  metric_name               = "SwapUsage"
  namespace                 = "AWS/RDS"
  statistic                 = "Average"
  threshold                 = (var.swap_usage_threshold / 100) * var.high_memory_capacity_gib * 1073741824
  treat_missing_data        = "breaching"
  alarm_actions             = concat(var.all_alarms_sns_arns, var.swap_usage_sns_arns)
  ok_actions                = concat(var.all_alarms_sns_arns, var.swap_usage_sns_arns)
  insufficient_data_actions = concat(var.all_alarms_sns_arns, var.swap_usage_sns_arns)

  dimensions = {
    DBInstanceIdentifier = var.db_instance_id
  }

  tags = merge(var.tags, {
    "InstanceId" = var.db_instance_id,
    "Terraform"  = "true"
  })
}
