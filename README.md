![image info](logo.jpeg)

# terraform-aws-cloudwatch-rds

This Terraform module provisions alarms using aws cloudwatch for monitoring and notification RDS. The module allows you to create alerts based on various performance metrics of your RDS, helping you to proactively manage and respond to potential issues in your RDS.

## Installation

To use this module, you need to have Terraform installed. You can find installation instructions on the Terraform website.

## Usage

The module will create cloudwatch alarms for your RDS. You can use this module multiple times to create alarms with different configurations for various instances or metrics.

```python


################################################################################
# Cloudwatch Alarms for RDS
################################################################################

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
  all_alarms_sns_arns      = [aws_sns_topic.sns_topic.arn]
  high_connections_max     = 1365
  high_memory_capacity_gib = 16
  depends_on               = [aws_sns_topic.sns_topic]
}

```

## information

1. high cpu- with threshold:
   You enter the threshold for CPU, for example 80%. In case of alerts, the solution will be increasing the cpu
   of your instance.

2. high memory- with threshold:
   You enter the threshold for Memory, for example 80%. You are also enter the memory allocate for your
   instance-id, which you can find here: [Link text Here](https://sysadminxpert.com/aws-rds-max-connections-
   limit/#google_vignette)
   In case of alerts, the solution will be increasing the memory of your instance.

3. high connections- with threshold:
   You enter the threshold for Connections, for example 80%. You are also enter the connections allocate for
   your instance-id, which you can find here: [Link text Here](https://sysadminxpert.com/aws-rds-max-
   connections-limit/#google_vignette)
   In case of alerts, the solution will be increasing the connections of your instance.

4. high local storage- with threshold:
   You enter the threshold for storage, for example 80%.
   In case of alerts, the solution will be increasing the storage of your instance.
   Only for aurora, the others don't have those metrics.

5. high write latency- in seconds
   You enter the number of seconds that you can bear as latency, the recommendation is 2sc.
   In case of alerts, you should decrease the traffic to your instance.

6. high read latency- in seconds
   You enter the number of seconds that you can bear as latency, the recommendation is 0.02sc.
   In case of alerts, you should decrease the traffic to your instance or add a read replica.

7. disk queue depth too high- with number
   You enter the number of depths that you can bear in your instance, the recommendation is 64.
   In case of alerting, the solution is change the disk type to something stronger.

8. swap usage too high- with threshold
   You enter the percentage of swap from RAM size, the recommendation is 10%-20% of swapping

9. high storage space- with threshold:
   You enter the threshold for storage, for example 80%.
   In case of alerts, the solution will be increasing the storage of your instance.

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
| [aws_cloudwatch_metric_alarm.high_local_storage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.high_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.high_read_latency](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.high_storage_space](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.high_write_latency](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.swap_usage_too_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_db_instance.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_instance) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_all_alarms_sns_arns"></a> [all\_alarms\_sns\_arns](#input\_all\_alarms\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_datapoints_to_alarm"></a> [datapoints\_to\_alarm](#input\_datapoints\_to\_alarm) | The number of data points that must be breaching to trigger the alarm. | `number` | `5` | no |
| <a name="input_db_instance_id"></a> [db\_instance\_id](#input\_db\_instance\_id) | The instance ID of the RDS database instance that you want to monitor. | `string` | n/a | yes |
| <a name="input_disk_queue_depth_enabled"></a> [disk\_queue\_depth\_enabled](#input\_disk\_queue\_depth\_enabled) | Enable disk queue depth alarm | `bool` | `true` | no |
| <a name="input_disk_queue_depth_sns_arns"></a> [disk\_queue\_depth\_sns\_arns](#input\_disk\_queue\_depth\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_disk_queue_depth_threshold"></a> [disk\_queue\_depth\_threshold](#input\_disk\_queue\_depth\_threshold) | The threshold for disk queue depth | `number` | `64` | no |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | The number of periods over which data is compared to the specified threshold. | `number` | `5` | no |
| <a name="input_high_connections_enabled"></a> [high\_connections\_enabled](#input\_high\_connections\_enabled) | Enable high connections alarm | `bool` | `true` | no |
| <a name="input_high_connections_max"></a> [high\_connections\_max](#input\_high\_connections\_max) | The maximum number of connections for the instance class | `number` | n/a | yes |
| <a name="input_high_connections_sns_arns"></a> [high\_connections\_sns\_arns](#input\_high\_connections\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_high_connections_threshold"></a> [high\_connections\_threshold](#input\_high\_connections\_threshold) | The threshold for high connections | `number` | `90` | no |
| <a name="input_high_cpu_enabled"></a> [high\_cpu\_enabled](#input\_high\_cpu\_enabled) | Enable high CPU alarm | `bool` | `true` | no |
| <a name="input_high_cpu_sns_arns"></a> [high\_cpu\_sns\_arns](#input\_high\_cpu\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_high_cpu_threshold"></a> [high\_cpu\_threshold](#input\_high\_cpu\_threshold) | The threshold for high CPU usage | `number` | `90` | no |
| <a name="input_high_local_storage_enabled"></a> [high\_local\_storage\_enabled](#input\_high\_local\_storage\_enabled) | Enable high storage alarm - for aurora | `bool` | `false` | no |
| <a name="input_high_local_storage_sns_arns"></a> [high\_local\_storage\_sns\_arns](#input\_high\_local\_storage\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_high_local_storage_threshold"></a> [high\_local\_storage\_threshold](#input\_high\_local\_storage\_threshold) | The threshold for high storage usage - for aurora | `number` | `90` | no |
| <a name="input_high_memory_capacity_gib"></a> [high\_memory\_capacity\_gib](#input\_high\_memory\_capacity\_gib) | The capacity memory for the instance class | `number` | n/a | yes |
| <a name="input_high_memory_enabled"></a> [high\_memory\_enabled](#input\_high\_memory\_enabled) | Enable high memory alarm | `bool` | `true` | no |
| <a name="input_high_memory_sns_arns"></a> [high\_memory\_sns\_arns](#input\_high\_memory\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_high_memory_threshold"></a> [high\_memory\_threshold](#input\_high\_memory\_threshold) | The threshold for high memory usage | `number` | `90` | no |
| <a name="input_high_read_latency_enabled"></a> [high\_read\_latency\_enabled](#input\_high\_read\_latency\_enabled) | Enable high read latency alarm | `bool` | `true` | no |
| <a name="input_high_read_latency_seconds"></a> [high\_read\_latency\_seconds](#input\_high\_read\_latency\_seconds) | The threshold for high read latency | `number` | `0.02` | no |
| <a name="input_high_read_latency_sns_arns"></a> [high\_read\_latency\_sns\_arns](#input\_high\_read\_latency\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_high_storage_space_enabled"></a> [high\_storage\_space\_enabled](#input\_high\_storage\_space\_enabled) | Enable high storage alarm | `bool` | `true` | no |
| <a name="input_high_storage_space_sns_arns"></a> [high\_storage\_space\_sns\_arns](#input\_high\_storage\_space\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_high_storage_space_threshold"></a> [high\_storage\_space\_threshold](#input\_high\_storage\_space\_threshold) | The threshold for high storage usage | `number` | `90` | no |
| <a name="input_high_write_latency_enabled"></a> [high\_write\_latency\_enabled](#input\_high\_write\_latency\_enabled) | Enable high write latency alarm | `bool` | `true` | no |
| <a name="input_high_write_latency_seconds"></a> [high\_write\_latency\_seconds](#input\_high\_write\_latency\_seconds) | The threshold for high write latency | `number` | `2` | no |
| <a name="input_high_write_latency_sns_arns"></a> [high\_write\_latency\_sns\_arns](#input\_high\_write\_latency\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_swap_usage_enabled"></a> [swap\_usage\_enabled](#input\_swap\_usage\_enabled) | Enable swap usage alarm | `bool` | `true` | no |
| <a name="input_swap_usage_sns_arns"></a> [swap\_usage\_sns\_arns](#input\_swap\_usage\_sns\_arns) | List of ARNs for the SNS topics | `list(string)` | `[]` | no |
| <a name="input_swap_usage_threshold"></a> [swap\_usage\_threshold](#input\_swap\_usage\_threshold) | The threshold for swap usage as percentage from RAM size | `number` | `10` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
