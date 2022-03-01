<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | ./modules/s3 | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |
| <a name="module_weather-app"></a> [weather-app](#module\_weather-app) | ./modules/fargate-env | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of the application that is being deployed | `string` | n/a | yes |
| <a name="input_az"></a> [az](#input\_az) | List of availability zones to deploy subnets to | `list(string)` | n/a | yes |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Specifies the name of an S3 Bucket | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Port that the container application is listening on | `number` | n/a | yes |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | The desired number of container instances to instantiate | `number` | n/a | yes |
| <a name="input_git_username"></a> [git\_username](#input\_git\_username) | Name of the Github user where the CI/CD workflow is running | `string` | n/a | yes |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | URI of the Container Image stored in ECR | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix applied to all resources as tag:Name | `string` | n/a | yes |
| <a name="input_subnets_private"></a> [subnets\_private](#input\_subnets\_private) | Object list of private subnets for deployment | <pre>list(object({<br>    name = string<br>    cidr = string<br>  }))</pre> | n/a | yes |
| <a name="input_subnets_public"></a> [subnets\_public](#input\_subnets\_public) | Object list of public subnets for deployment | <pre>list(object({<br>    name = string<br>    cidr = string<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to identify project resources | `map(string)` | n/a | yes |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | The hard limit of CPU units to present to the ECS task | `number` | n/a | yes |
| <a name="input_task_mem"></a> [task\_mem](#input\_task\_mem) | The hard limit of memory units to present to the ECS task | `number` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | String representing the CIDR of the VPC CIDR block | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_fqdn"></a> [alb\_fqdn](#output\_alb\_fqdn) | FQDN of the ALB |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the S3 bucket |
| <a name="output_bucket_name_arn"></a> [bucket\_name\_arn](#output\_bucket\_name\_arn) | ARN of the S3 bucket |
<!-- END_TF_DOCS -->