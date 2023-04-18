## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.52.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.52.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_linux_web_app"></a> [linux\_web\_app](#module\_linux\_web\_app) | ./modules/linux_web_app | n/a |
| <a name="module_windows_web_app"></a> [windows\_web\_app](#module\_windows\_web\_app) | ./modules/windows_web_app | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_service_plan.appserviceplan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_environment_id"></a> [app\_service\_environment\_id](#input\_app\_service\_environment\_id) | The ID of the App Service Environment to create this Service Plan in. Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm\_app\_service\_environment, or I1v2, I2v2, I3v2 for azurerm\_app\_service\_environment\_v3 | `string` | `null` | no |
| <a name="input_app_service_logs"></a> [app\_service\_logs](#input\_app\_service\_logs) | Configuration of the App Service and App Service Slot logs. Documentation [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app#logs) | <pre>object({<br>    detailed_error_messages = optional(bool)<br>    failed_request_tracing  = optional(bool)<br>    application_logs = optional(object({<br>      file_system_level = string<br>      azure_blob_storage = optional(object({<br>        level             = string<br>        retention_in_days = number<br>        sas_url           = string<br>      }))<br>    }))<br>    http_logs = optional(object({<br>      azure_blob_storage = optional(object({<br>        retention_in_days = number<br>        sas_url           = string<br>      }))<br>      file_system = optional(object({<br>        retention_in_days = number<br>        retention_in_mb   = number<br>      }))<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_app_service_name"></a> [app\_service\_name](#input\_app\_service\_name) | Name of the App Service | `string` | `"linux_web_app"` | no |
| <a name="input_app_service_plan_name"></a> [app\_service\_plan\_name](#input\_app\_service\_plan\_name) | Specifies the name of the App Service Plan component | `string` | `""` | no |
| <a name="input_app_service_vnet_integration_subnet_id"></a> [app\_service\_vnet\_integration\_subnet\_id](#input\_app\_service\_vnet\_integration\_subnet\_id) | Id of the subnet to associate with the app service | `string` | `null` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | Application settings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#app_settings | `map(string)` | `{}` | no |
| <a name="input_application_insights_enabled"></a> [application\_insights\_enabled](#input\_application\_insights\_enabled) | Use Application Insights for this App Service | `bool` | `true` | no |
| <a name="input_application_insights_id"></a> [application\_insights\_id](#input\_application\_insights\_id) | Name of the existing Application Insights to use instead of deploying a new one. | `string` | `null` | no |
| <a name="input_application_insights_name"></a> [application\_insights\_name](#input\_application\_insights\_name) | Name of the Application Insights | `string` | `"application_insights"` | no |
| <a name="input_application_insights_retention_in_days"></a> [application\_insights\_retention\_in\_days](#input\_application\_insights\_retention\_in\_days) | Specifies the retention period in days | `number` | `90` | no |
| <a name="input_application_insights_sampling_percentage"></a> [application\_insights\_sampling\_percentage](#input\_application\_insights\_sampling\_percentage) | Specifies the percentage of sampled datas for Application Insights. Documentation [here](https://docs.microsoft.com/en-us/azure/azure-monitor/app/sampling#ingestion-sampling) | `number` | `null` | no |
| <a name="input_application_insights_type"></a> [application\_insights\_type](#input\_application\_insights\_type) | Application type for Application Insights resource | `string` | `"web"` | no |
| <a name="input_auth_settings"></a> [auth\_settings](#input\_auth\_settings) | Authentication settings. Issuer URL is generated thanks to the tenant ID. For active\_directory block, the allowed\_audiences list is filled with a value generated with the name of the App Service. See https://www.terraform.io/docs/providers/azurerm/r/app_service.html#auth_settings | `any` | `{}` | no |
| <a name="input_backup_enabled"></a> [backup\_enabled](#input\_backup\_enabled) | `true` to enable App Service backup | `bool` | `true` | no |
| <a name="input_backup_settings"></a> [backup\_settings](#input\_backup\_settings) | Backup settings for App service | <pre>object({<br>    name                     = string<br>    enabled                  = bool<br>    storage_account_url      = optional(string)<br>    frequency_interval       = number<br>    frequency_unit           = optional(string)<br>    retention_period_in_days = optional(number)<br>    start_time               = optional(string)<br>  })</pre> | <pre>{<br>  "enabled": false,<br>  "frequency_interval": 1,<br>  "frequency_unit": "Day",<br>  "name": "DefaultBackup",<br>  "retention_period_in_days": 1<br>}</pre> | no |
| <a name="input_client_affinity_enabled"></a> [client\_affinity\_enabled](#input\_client\_affinity\_enabled) | Client affinity activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_affinity_enabled | `bool` | `false` | no |
| <a name="input_client_certificate_enabled"></a> [client\_certificate\_enabled](#input\_client\_certificate\_enabled) | Client certificate activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_certificate_enabled | `bool` | `false` | no |
| <a name="input_connection_strings"></a> [connection\_strings](#input\_connection\_strings) | Connection strings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#connection_string | `list(map(string))` | `[]` | no |
| <a name="input_custom_domains"></a> [custom\_domains](#input\_custom\_domains) | Custom domains and SSL certificates of the App Service. Could declare a custom domain with SSL binding. SSL certificate could be provided from an Azure Keyvault Certificate Secret or from a file with following attributes :<pre>- certificate_file:                     Path of the certificate file.<br>- certificate_password:                 Certificate password.<br>- certificate_keyvault_certificate_id:  ID of the Azure Keyvault Certificate Secret.<br>- certificate_id:                       ID of an existant certificate.</pre> | <pre>map(object({<br>    certificate_file                    = optional(string)<br>    certificate_password                = optional(string)<br>    certificate_keyvault_certificate_id = optional(string)<br>    certificate_id                      = optional(string)<br>  }))</pre> | `null` | no |
| <a name="input_docker_image"></a> [docker\_image](#input\_docker\_image) | Docker image to use for this App Service | <pre>object({<br>    name     = string<br>    tag      = string<br>    slot_tag = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add. | `map(string)` | `{}` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | HTTPS restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#https_only | `bool` | `false` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Identity to be assigned to this Linux Web App Slot. | `any` | `{}` | no |
| <a name="input_internet_ingestion_enabled"></a> [internet\_ingestion\_enabled](#input\_internet\_ingestion\_enabled) | Should the Application Insights component support ingestion over the Public Internet? | `bool` | `true` | no |
| <a name="input_internet_query_enabled"></a> [internet\_query\_enabled](#input\_internet\_query\_enabled) | Should the Application Insights component support querying over the Public Internet? | `bool` | `true` | no |
| <a name="input_ip_restriction_headers"></a> [ip\_restriction\_headers](#input\_ip\_restriction\_headers) | IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers | `map(list(string))` | `null` | no |
| <a name="input_key_vault_reference_identity_id"></a> [key\_vault\_reference\_identity\_id](#input\_key\_vault\_reference\_identity\_id) | User Assigned Identity ID used for accessing KeyVault secrets | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table' | `string` | `""` | no |
| <a name="input_maximum_elastic_worker_count"></a> [maximum\_elastic\_worker\_count](#input\_maximum\_elastic\_worker\_count) | The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU. | `number` | `null` | no |
| <a name="input_mount_points"></a> [mount\_points](#input\_mount\_points) | Storage Account mount points. Name is generated if not set and default type is AzureFiles. See https://www.terraform.io/docs/providers/azurerm/r/app_service.html#storage_account | `list(map(string))` | `[]` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The O/S type for the App Services to be hosted in this plan. Possible values include `Windows`, `Linux`, and `WindowsContainer`. | `string` | n/a | yes |
| <a name="input_password_end_date"></a> [password\_end\_date](#input\_password\_end\_date) | The relative duration or RFC3339 rotation timestamp after which the password expire | `string` | `null` | no |
| <a name="input_password_rotation_in_years"></a> [password\_rotation\_in\_years](#input\_password\_rotation\_in\_years) | Number of years to add to the base timestamp to configure the password rotation timestamp. Conflicts with password\_end\_date and either one is specified and not the both | `number` | `2` | no |
| <a name="input_per_site_scaling_enabled"></a> [per\_site\_scaling\_enabled](#input\_per\_site\_scaling\_enabled) | Should Per Site Scaling be enabled. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A container that holds related resources for an Azure solution | `string` | `""` | no |
| <a name="input_scm_ip_restriction_headers"></a> [scm\_ip\_restriction\_headers](#input\_scm\_ip\_restriction\_headers) | IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers | `map(list(string))` | `null` | no |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | Site config for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is no more managed in this block. | `any` | <pre>{<br>  "always_on": "true"<br>}</pre> | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU for the plan. Possible values include B1, B2, B3, D1, F1, FREE, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, Y1, EP1, EP2, EP3, WS1, WS2, and WS3. | `string` | n/a | yes |
| <a name="input_staging_slot_app_settings"></a> [staging\_slot\_app\_settings](#input\_staging\_slot\_app\_settings) | Override staging slot with custom app settings | `map(string)` | `null` | no |
| <a name="input_staging_slot_enabled"></a> [staging\_slot\_enabled](#input\_staging\_slot\_enabled) | Create a staging slot alongside the app service for blue/green deployment purposes. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_slot | `bool` | `true` | no |
| <a name="input_staging_slot_name"></a> [staging\_slot\_name](#input\_staging\_slot\_name) | Name of the app service slot | `string` | `null` | no |
| <a name="input_sticky_settings"></a> [sticky\_settings](#input\_sticky\_settings) | Lists of connection strings and app settings to prevent from swapping between slots. | <pre>object({<br>    app_setting_names       = optional(list(string))<br>    connection_string_names = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the azure storage account | `string` | `""` | no |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | The name of the storage container to keep backups | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add. | `map(string)` | `{}` | no |
| <a name="input_worker_count"></a> [worker\_count](#input\_worker\_count) | The number of Workers (instances) to be allocated. | `number` | `3` | no |
| <a name="input_zone_balancing_enabled"></a> [zone\_balancing\_enabled](#input\_zone\_balancing\_enabled) | Should the Service Plan balance across Availability Zones in the region. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_service_linux"></a> [app\_service\_linux](#output\_app\_service\_linux) | App Service Linux (Linux WebApp) output object if Linux is choosen. Please refer to `./modules/linux-web-app/README.md` |
| <a name="output_app_service_windows"></a> [app\_service\_windows](#output\_app\_service\_windows) | App Service Windows (Windows WebApp) output object if Windows is choosen. Please refer to `./modules/windows-web-app/README.md` |
| <a name="output_service_plan_id"></a> [service\_plan\_id](#output\_service\_plan\_id) | ID of the created Service Plan |
| <a name="output_service_plan_location"></a> [service\_plan\_location](#output\_service\_plan\_location) | Azure location of the created Service Plan |
| <a name="output_service_plan_name"></a> [service\_plan\_name](#output\_service\_plan\_name) | Name of the created Service Plan |
