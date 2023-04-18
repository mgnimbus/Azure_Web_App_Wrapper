## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_linux_app"></a> [linux\_app](#module\_linux\_app) | ../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_name"></a> [app\_service\_name](#input\_app\_service\_name) | Name of the App Service | `string` | `"linux_web_app"` | no |
| <a name="input_app_service_plan_name"></a> [app\_service\_plan\_name](#input\_app\_service\_plan\_name) | Specifies the name of the App Service Plan component | `string` | `""` | no |
| <a name="input_backup_enabled"></a> [backup\_enabled](#input\_backup\_enabled) | `true` to enable App Service backup | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location. | `string` | `""` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The O/S type for the App Services to be hosted in this plan. Possible values include `Windows`, `Linux`, and `WindowsContainer`. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A container that holds related resources for an Azure solution | `string` | `""` | no |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | Site config for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is no more managed in this block. | `any` | <pre>{<br>  "always_on": "true"<br>}</pre> | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU for the plan | `string` | n/a | yes |
| <a name="input_staging_slot_enabled"></a> [staging\_slot\_enabled](#input\_staging\_slot\_enabled) | Create a staging slot alongside the app service for blue/green deployment purposes. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_slot | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add. | `map(string)` | `{}` | no |

## Outputs

No outputs.
