variable "high_cpu_threshold" {
  description = "The threshold for high CPU usage"
  type        = number
  default     = 90

}
variable "high_cpu_enabled" {
  description = "Enable high CPU alarm"
  type        = bool
  default     = true

}
variable "high_cpu_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}
variable "high_memory_threshold" {
  description = "The threshold for high memory usage"
  type        = number
  default     = 90

}
variable "high_memory_capacity_gib" {
  description = "The capacity memory for the instance class"
  type        = number
}
variable "high_memory_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}
variable "high_memory_enabled" {
  description = "Enable high memory alarm"
  type        = bool
  default     = true

}
variable "high_connections_threshold" {
  description = "The threshold for high connections"
  type        = number
  default     = 90

}
variable "high_connections_max" {
  description = "The maximum number of connections for the instance class"
  type        = number
}
variable "high_connections_enabled" {
  description = "Enable high connections alarm"
  type        = bool
  default     = true

}
variable "high_connections_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}
variable "high_local_storage_threshold" {
  description = "The threshold for high storage usage - for aurora"
  type        = number
  default     = 90

}
variable "high_local_storage_enabled" {
  description = "Enable high storage alarm - for aurora"
  type        = bool
  default     = false

}
variable "high_local_storage_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}

variable "high_storage_space_threshold" {
  description = "The threshold for high storage usage"
  type        = number
  default     = 90

}
variable "high_storage_space_enabled" {
  description = "Enable high storage alarm"
  type        = bool
  default     = true

}
variable "high_storage_space_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}

variable "high_write_latency_seconds" {
  description = "The threshold for high write latency"
  type        = number
  default     = 2

}
variable "high_write_latency_enabled" {
  description = "Enable high write latency alarm"
  type        = bool
  default     = true

}
variable "high_write_latency_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}
variable "high_read_latency_seconds" {
  description = "The threshold for high read latency"
  type        = number
  default     = 0.02

}
variable "high_read_latency_enabled" {
  description = "Enable high read latency alarm"
  type        = bool
  default     = true

}
variable "high_read_latency_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}
variable "disk_queue_depth_threshold" {
  description = "The threshold for disk queue depth"
  type        = number
  default     = 64

}
variable "disk_queue_depth_enabled" {
  description = "Enable disk queue depth alarm"
  type        = bool
  default     = true

}
variable "disk_queue_depth_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}
variable "swap_usage_threshold" {
  description = "The threshold for swap usage as percentage from RAM size"
  type        = number
  default     = 10

}
variable "swap_usage_enabled" {
  description = "Enable swap usage alarm"
  type        = bool
  default     = true

}
variable "swap_usage_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}
variable "db_instance_id" {
  description = "The instance ID of the RDS database instance that you want to monitor."
  type        = string
}
variable "all_alarms_sns_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}
variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold."
  type        = number
  default     = 5
  
}
variable "datapoints_to_alarm" {
  description = "The number of data points that must be breaching to trigger the alarm."
  type        = number
  default     = 5
  
}