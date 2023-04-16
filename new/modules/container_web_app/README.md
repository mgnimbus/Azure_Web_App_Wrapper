## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_certificate.app_service_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate) | resource |
| [azurerm_app_service_custom_hostname_binding.app_service_custom_hostname_binding](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_custom_hostname_binding) | resource |
| [azurerm_app_service_slot_virtual_network_swift_connection.app_service_slot_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_slot_virtual_network_swift_connection) | resource |
| [azurerm_app_service_virtual_network_swift_connection.app_service_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_application_insights.app_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_linux_web_app.app_service_linux_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_linux_web_app_slot.app_service_linux_container_slot](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app_slot) | resource |
| [azurerm_app_service_certificate.certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/app_service_certificate) | data source |
| [azurerm_application_insights.app_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_client_config.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_logs"></a> [app\_service\_logs](#input\_app\_service\_logs) | Configuration of the App Service and App Service Slot logs. Documentation [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app#logs) | <pre>object({<br>    detailed_error_messages = optional(bool)<br>    failed_request_tracing  = optional(bool)<br>    application_logs = optional(object({<br>      file_system_level = string<br>      azure_blob_storage = optional(object({<br>        level             = string<br>        retention_in_days = number<br>        sas_url           = string<br>      }))<br>    }))<br>    http_logs = optional(object({<br>      azure_blob_storage = optional(object({<br>        retention_in_days = number<br>        sas_url           = string<br>      }))<br>      file_system = optional(object({<br>        retention_in_days = number<br>        retention_in_mb   = number<br>      }))<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_app_service_name"></a> [app\_service\_name](#input\_app\_service\_name) | Name of the App Service | `string` | `"linux_web_app"` | no |
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
| <a name="input_backup_frequency_interval"></a> [backup\_frequency\_interval](#input\_backup\_frequency\_interval) | Frequency interval for the App Service backup. | `number` | `1` | no |
| <a name="input_backup_frequency_unit"></a> [backup\_frequency\_unit](#input\_backup\_frequency\_unit) | Frequency unit for the App Service backup. Possible values are `Day` or `Hour`. | `string` | `"Day"` | no |
| <a name="input_backup_keep_at_least_one_backup"></a> [backup\_keep\_at\_least\_one\_backup](#input\_backup\_keep\_at\_least\_one\_backup) | Should the service keep at least one backup, regardless of age of backup. | `bool` | `true` | no |
| <a name="input_backup_name"></a> [backup\_name](#input\_backup\_name) | Name for backup | `string` | `"DefaultBackup"` | no |
| <a name="input_backup_retention_period_in_days"></a> [backup\_retention\_period\_in\_days](#input\_backup\_retention\_period\_in\_days) | Retention in days for the App Service backup. | `number` | `30` | no |
| <a name="input_client_affinity_enabled"></a> [client\_affinity\_enabled](#input\_client\_affinity\_enabled) | Client affinity activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_affinity_enabled | `bool` | `false` | no |
| <a name="input_client_certificate_enabled"></a> [client\_certificate\_enabled](#input\_client\_certificate\_enabled) | Client certificate activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_certificate_enabled | `bool` | `false` | no |
| <a name="input_connection_strings"></a> [connection\_strings](#input\_connection\_strings) | Connection strings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#connection_string | `list(map(string))` | `[]` | no |
| <a name="input_custom_domains"></a> [custom\_domains](#input\_custom\_domains) | Custom domains and SSL certificates of the App Service. Could declare a custom domain with SSL binding. SSL certificate could be provided from an Azure Keyvault Certificate Secret or from a file with following attributes :<pre>- certificate_file:                     Path of the certificate file.<br>- certificate_password:                 Certificate password.<br>- certificate_keyvault_certificate_id:  ID of the Azure Keyvault Certificate Secret.<br>- certificate_id:                       ID of an existant certificate.</pre> | <pre>map(object({<br>    certificate_file                    = optional(string)<br>    certificate_password                = optional(string)<br>    certificate_keyvault_certificate_id = optional(string)<br>    certificate_id                      = optional(string)<br>  }))</pre> | `null` | no |
| <a name="input_docker_image"></a> [docker\_image](#input\_docker\_image) | Docker image to use for this App Service | <pre>object({<br>    name     = string<br>    tag      = string<br>    slot_tag = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add. | `map(string)` | `{}` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | HTTPS restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#https_only | `bool` | `false` | no |
| <a name="input_internet_ingestion_enabled"></a> [internet\_ingestion\_enabled](#input\_internet\_ingestion\_enabled) | Should the Application Insights component support ingestion over the Public Internet? | `bool` | `true` | no |
| <a name="input_internet_query_enabled"></a> [internet\_query\_enabled](#input\_internet\_query\_enabled) | Should the Application Insights component support querying over the Public Internet? | `bool` | `true` | no |
| <a name="input_ip_restriction_headers"></a> [ip\_restriction\_headers](#input\_ip\_restriction\_headers) | IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers | `map(list(string))` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location. | `string` | n/a | yes |
| <a name="input_mount_points"></a> [mount\_points](#input\_mount\_points) | Storage Account mount points. Name is generated if not set and default type is AzureFiles. See https://www.terraform.io/docs/providers/azurerm/r/app_service.html#storage_account | `list(map(string))` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_scm_ip_restriction_headers"></a> [scm\_ip\_restriction\_headers](#input\_scm\_ip\_restriction\_headers) | IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers | `map(list(string))` | `null` | no |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | ID of the Service Plan that hosts the App Service | `string` | n/a | yes |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | Site config for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is no more managed in this block. | `any` | <pre>{<br>  "always_on": "true"<br>}</pre> | no |
| <a name="input_staging_slot_app_settings"></a> [staging\_slot\_app\_settings](#input\_staging\_slot\_app\_settings) | Override staging slot with custom app settings | `map(string)` | `null` | no |
| <a name="input_staging_slot_enabled"></a> [staging\_slot\_enabled](#input\_staging\_slot\_enabled) | Create a staging slot alongside the app service for blue/green deployment purposes. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_slot | `bool` | `true` | no |
| <a name="input_staging_slot_name"></a> [staging\_slot\_name](#input\_staging\_slot\_name) | Name of the app service slot | `string` | `null` | no |
| <a name="input_sticky_settings"></a> [sticky\_settings](#input\_sticky\_settings) | Lists of connection strings and app settings to prevent from swapping between slots. | <pre>object({<br>    app_setting_names       = optional(list(string))<br>    connection_string_names = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_storage_account_url"></a> [storage\_account\_url](#input\_storage\_account\_url) | n/a | `string` | `" SAS URL to the container"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_insights_app_id"></a> [app\_insights\_app\_id](#output\_app\_insights\_app\_id) | Deprecated, use `application_insights_app_id` |
| <a name="output_app_insights_application_type"></a> [app\_insights\_application\_type](#output\_app\_insights\_application\_type) | Deprecated, use `application_insights_application_type` |
| <a name="output_app_insights_id"></a> [app\_insights\_id](#output\_app\_insights\_id) | Deprecated, use `application_insights_id` |
| <a name="output_app_insights_instrumentation_key"></a> [app\_insights\_instrumentation\_key](#output\_app\_insights\_instrumentation\_key) | Deprecated, use `application_insights_instrumentation_key` |
| <a name="output_app_insights_name"></a> [app\_insights\_name](#output\_app\_insights\_name) | Deprecated, use `application_insights_name` |
| <a name="output_app_service_certificates_id"></a> [app\_service\_certificates\_id](#output\_app\_service\_certificates\_id) | ID of certificates generated. |
| <a name="output_app_service_default_site_hostname"></a> [app\_service\_default\_site\_hostname](#output\_app\_service\_default\_site\_hostname) | The Default Hostname associated with the App Service |
| <a name="output_app_service_id"></a> [app\_service\_id](#output\_app\_service\_id) | Id of the App Service |
| <a name="output_app_service_identity_service_principal_id"></a> [app\_service\_identity\_service\_principal\_id](#output\_app\_service\_identity\_service\_principal\_id) | Id of the Service principal identity of the App Service |
| <a name="output_app_service_name"></a> [app\_service\_name](#output\_app\_service\_name) | Name of the App Service |
| <a name="output_app_service_outbound_ip_addresses"></a> [app\_service\_outbound\_ip\_addresses](#output\_app\_service\_outbound\_ip\_addresses) | Outbound IP adresses of the App Service |
| <a name="output_app_service_possible_outbound_ip_addresses"></a> [app\_service\_possible\_outbound\_ip\_addresses](#output\_app\_service\_possible\_outbound\_ip\_addresses) | Possible outbound IP adresses of the App Service |
| <a name="output_app_service_site_credential"></a> [app\_service\_site\_credential](#output\_app\_service\_site\_credential) | Site credential block of the App Service |
| <a name="output_app_service_slot_identity_service_principal_id"></a> [app\_service\_slot\_identity\_service\_principal\_id](#output\_app\_service\_slot\_identity\_service\_principal\_id) | Id of the Service principal identity of the App Service slot |
| <a name="output_app_service_slot_name"></a> [app\_service\_slot\_name](#output\_app\_service\_slot\_name) | Name of the App Service slot |
| <a name="output_application_insights_app_id"></a> [application\_insights\_app\_id](#output\_application\_insights\_app\_id) | App id of the Application Insights associated to the App Service |
| <a name="output_application_insights_application_type"></a> [application\_insights\_application\_type](#output\_application\_insights\_application\_type) | Application Type of the Application Insights associated to the App Service |
| <a name="output_application_insights_id"></a> [application\_insights\_id](#output\_application\_insights\_id) | Id of the Application Insights associated to the App Service |
| <a name="output_application_insights_instrumentation_key"></a> [application\_insights\_instrumentation\_key](#output\_application\_insights\_instrumentation\_key) | Instrumentation key of the Application Insights associated to the App Service |
| <a name="output_application_insights_name"></a> [application\_insights\_name](#output\_application\_insights\_name) | Name of the Application Insights associated to the App Service |
| <a name="output_service_plan_id"></a> [service\_plan\_id](#output\_service\_plan\_id) | ID of the Service Plan |
