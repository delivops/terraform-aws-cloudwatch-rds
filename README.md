# terraform-aws-rds-cloudwatch

This Terraform module provisions alarms using aws cloudwatch for monitoring and notification RDS. The module allows you to create alerts based on various performance metrics of your RDS, helping you to proactively manage and respond to potential issues in your RDS.

## Installation

To use this module, you need to have Terraform installed. You can find installation instructions on the Terraform website.

## Usage

The module will create cloudwatch alarms for your RDS. You can use this module multiple times to create alarms with different configurations for various instances or metrics.

```python


################################################################################
# Cloudwatch Alarms for RDS
################################################################################



module "test-aurora-1-alarms" {
  source          = "delivops/alerts/groundcover"
  version         = "0.0.X"
  db_instance_id                   = "test-aurora-1"
  aws_sns_topic_arn                = aws_sns_topic.opsgenie_topic.arn
  high_connections_max_connections = 1365
  high_memory_max_allocations      = 16
  depends_on = [ aws_sns_topic.opsgenie_topic ]
}


```

## information

1. high cpu- with threshold:
   You enter the threshold for CPU, for example 80%. In case of alerts, the solution will be increasing the cpu of your instance.
2. high memory- with threshold:
   You enter the threshold for Memory, for example 80%. You are also enter the memory allocate for your instance-id, which you can find here: [Link text Here](https://sysadminxpert.com/aws-rds-max-connections-limit/#google_vignette)
   In case of alerts, the solution will be increasing the memory of your instance.
3. high connections- with threshold:
   You enter the threshold for Connections, for example 80%. You are also enter the connections allocate for your instance-id, which you can find here: [Link text Here](https://sysadminxpert.com/aws-rds-max-connections-limit/#google_vignette)
   In case of alerts, the solution will be increasing the connections of your instance.
4. high storage- with threshold:
   You enter the threshold for storage, for example 80%.
   In case of alerts, the solution will be increasing the storage of your instance.
5. high write latency- with seconds
   You enter the number of seconds that you can bear as latency, the recommendation is 2sc.
   In case of alerts, you should decrease the traffic to your instance.
6. high read latency- with seconds
   You enter the number of seconds that you can bear as latency, the recommendation is 0.02sc.
   In case of alerts, you should decrease the traffic to your instance or add a read replica.
7. disk queue depth too high- with number
   You enter the number of depths that you can bear in your instance, the recommendation is 64.
   In case of alerting, the solution is increasing the read/write capacity of your instance.
8. swap usage too high- with number
   You enter the number of memory allocate for swap that you can bear in your instance, the recommendation is 256000000 (256MB).
   In case of alerting, the solution is increasing the memory of your instance.

## License

MIT

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.disk_queue_depth_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.high_connections](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.high_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.high_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.high_read_latency](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.high_storage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.high_write_latency](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.swap_usage_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_db_instance.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_instance) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_sns_topic_arn"></a> [aws\_sns\_topic\_arn](#input\_aws\_sns\_topic\_arn) | The ARN of the SNS topic to send CloudWatch alarms to. | `string` | n/a | yes |
| <a name="input_db_instance_id"></a> [db\_instance\_id](#input\_db\_instance\_id) | The instance ID of the RDS database instance that you want to monitor. | `string` | n/a | yes |
| <a name="input_disk_queue_depth_enabled"></a> [disk\_queue\_depth\_enabled](#input\_disk\_queue\_depth\_enabled) | Enable disk queue depth alarm | `bool` | `true` | no |
| <a name="input_disk_queue_depth_threshold"></a> [disk\_queue\_depth\_threshold](#input\_disk\_queue\_depth\_threshold) | The threshold for disk queue depth | `number` | `64` | no |
| <a name="input_high_connections_enabled"></a> [high\_connections\_enabled](#input\_high\_connections\_enabled) | Enable high connections alarm | `bool` | `true` | no |
| <a name="input_high_connections_max"></a> [high\_connections\_max](#input\_high\_connections\_max) | The maximum number of connections for the instance class | `number` | n/a | yes |
| <a name="input_high_connections_threshold"></a> [high\_connections\_threshold](#input\_high\_connections\_threshold) | The threshold for high connections | `number` | `90` | no |
| <a name="input_high_cpu_enabled"></a> [high\_cpu\_enabled](#input\_high\_cpu\_enabled) | Enable high CPU alarm | `bool` | `true` | no |
| <a name="input_high_cpu_threshold"></a> [high\_cpu\_threshold](#input\_high\_cpu\_threshold) | The threshold for high CPU usage | `number` | `90` | no |
| <a name="input_high_memory_capacity_gib"></a> [high\_memory\_capacity\_gib](#input\_high\_memory\_capacity\_gib) | The capacity memory for the instance class | `number` | n/a | yes |
| <a name="input_high_memory_enabled"></a> [high\_memory\_enabled](#input\_high\_memory\_enabled) | Enable high memory alarm | `bool` | `true` | no |
| <a name="input_high_memory_threshold"></a> [high\_memory\_threshold](#input\_high\_memory\_threshold) | The threshold for high memory usage | `number` | `90` | no |
| <a name="input_high_read_latency_enabled"></a> [high\_read\_latency\_enabled](#input\_high\_read\_latency\_enabled) | Enable high read latency alarm | `bool` | `true` | no |
| <a name="input_high_read_latency_seconds"></a> [high\_read\_latency\_seconds](#input\_high\_read\_latency\_seconds) | The threshold for high read latency | `number` | `0.02` | no |
| <a name="input_high_storage_enabled"></a> [high\_storage\_enabled](#input\_high\_storage\_enabled) | Enable high storage alarm | `bool` | `true` | no |
| <a name="input_high_storage_threshold"></a> [high\_storage\_threshold](#input\_high\_storage\_threshold) | The threshold for high storage usage | `number` | `90` | no |
| <a name="input_high_write_latency_enabled"></a> [high\_write\_latency\_enabled](#input\_high\_write\_latency\_enabled) | Enable high write latency alarm | `bool` | `true` | no |
| <a name="input_high_write_latency_seconds"></a> [high\_write\_latency\_seconds](#input\_high\_write\_latency\_seconds) | The threshold for high write latency | `number` | `2` | no |
| <a name="input_swap_usage_enabled"></a> [swap\_usage\_enabled](#input\_swap\_usage\_enabled) | Enable swap usage alarm | `bool` | `true` | no |
| <a name="input_swap_usage_threshold_bytes"></a> [swap\_usage\_threshold\_bytes](#input\_swap\_usage\_threshold\_bytes) | The threshold for swap usage | `number` | `256000000` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->