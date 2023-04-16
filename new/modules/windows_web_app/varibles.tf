variable "location" {
  description = "Azure location."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

#Application Insights
variable "application_insights_enabled" {
  description = "Use Application Insights for this App Service"
  type        = bool
  default     = true
}

variable "application_insights_id" {
  description = "Name of the existing Application Insights to use instead of deploying a new one."
  type        = string
  default     = null
}

variable "application_insights_name" {
  description = "Name of the Application Insights"
  type        = string
  default     = "application_insights"
}

variable "application_insights_type" {
  description = "Application type for Application Insights resource"
  type        = string
  default     = "web"
}

variable "application_insights_sampling_percentage" {
  description = "Specifies the percentage of sampled datas for Application Insights. Documentation [here](https://docs.microsoft.com/en-us/azure/azure-monitor/app/sampling#ingestion-sampling)"
  type        = number
  default     = null
}

variable "application_insights_retention_in_days" {
  description = "Specifies the retention period in days"
  type        = number
  default     = 90
}

variable "internet_ingestion_enabled" {
  description = "Should the Application Insights component support ingestion over the Public Internet?"
  type        = bool
  default     = true
}

variable "internet_query_enabled" {
  description = "Should the Application Insights component support querying over the Public Internet?"
  type        = bool
  default     = true
}


## Azurerm Linux Web App

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
  default     = "linux_web_app"
}

variable "service_plan_id" {
  description = "ID of the Service Plan that hosts the App Service"
  type        = string
}

variable "site_config" {
  description = "Site config for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is no more managed in this block."
  type        = any
  default = {
    always_on = "true"
  }
}

variable "ip_restriction_headers" {
  description = "IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers"
  type        = map(list(string))
  default     = null
}

variable "app_settings" {
  description = "Application settings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#app_settings"
  type        = map(string)
  default     = {}
}

variable "scm_ip_restriction_headers" {
  description = "IPs restriction headers for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#headers"
  type        = map(list(string))
  default     = null
}

variable "connection_strings" {
  description = "Connection strings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#connection_string"
  type        = list(map(string))
  default     = []
}

variable "sticky_settings" {
  description = "Lists of connection strings and app settings to prevent from swapping between slots."
  type = object({
    app_setting_names       = optional(list(string))
    connection_string_names = optional(list(string))
  })
  default = null
}

variable "auth_settings" {
  description = "Authentication settings. Issuer URL is generated thanks to the tenant ID. For active_directory block, the allowed_audiences list is filled with a value generated with the name of the App Service. See https://www.terraform.io/docs/providers/azurerm/r/app_service.html#auth_settings"
  type        = any
  default     = {}
}


variable "client_affinity_enabled" {
  description = "Client affinity activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_affinity_enabled"
  type        = bool
  default     = false
}

variable "https_only" {
  description = "HTTPS restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#https_only"
  type        = bool
  default     = false
}

variable "client_certificate_enabled" {
  description = "Client certificate activation for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#client_certificate_enabled"
  type        = bool
  default     = false
}

# Backup

variable "backup_enabled" {
  description = "`true` to enable App Service backup"
  type        = bool
  default     = true
}

variable "backup_name" {
  description = "Name for backup"
  type        = string
  default     = "DefaultBackup"
}

variable "storage_account_url" {
  default = " SAS URL to the container"
  type    = string

}

variable "backup_frequency_interval" {
  description = "Frequency interval for the App Service backup."
  type        = number
  default     = 1
}

variable "backup_frequency_unit" {
  description = "Frequency unit for the App Service backup. Possible values are `Day` or `Hour`."
  type        = string
  default     = "Day"
}

variable "backup_retention_period_in_days" {
  description = "Retention in days for the App Service backup."
  type        = number
  default     = 30
}

variable "backup_keep_at_least_one_backup" {
  description = "Should the service keep at least one backup, regardless of age of backup."
  type        = bool
  default     = true
}

variable "mount_points" {
  description = "Storage Account mount points. Name is generated if not set and default type is AzureFiles. See https://www.terraform.io/docs/providers/azurerm/r/app_service.html#storage_account"
  type        = list(map(string))
  default     = []
}

variable "app_service_logs" {
  description = "Configuration of the App Service and App Service Slot logs. Documentation [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app#logs)"
  type = object({
    detailed_error_messages = optional(bool)
    failed_request_tracing  = optional(bool)
    application_logs = optional(object({
      file_system_level = string
      azure_blob_storage = optional(object({
        level             = string
        retention_in_days = number
        sas_url           = string
      }))
    }))
    http_logs = optional(object({
      azure_blob_storage = optional(object({
        retention_in_days = number
        sas_url           = string
      }))
      file_system = optional(object({
        retention_in_days = number
        retention_in_mb   = number
      }))
    }))
  })
  default = null
}

# App solt

variable "staging_slot_enabled" {
  type        = bool
  description = "Create a staging slot alongside the app service for blue/green deployment purposes. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_slot"
  default     = true
}

variable "staging_slot_name" {
  type        = string
  description = "Name of the app service slot"
  default     = null
}

# azurerm_app_service_certificate

variable "custom_domains" {
  description = <<EOD
Custom domains and SSL certificates of the App Service. Could declare a custom domain with SSL binding. SSL certificate could be provided from an Azure Keyvault Certificate Secret or from a file with following attributes :
```
- certificate_file:                     Path of the certificate file.
- certificate_password:                 Certificate password.
- certificate_keyvault_certificate_id:  ID of the Azure Keyvault Certificate Secret.
- certificate_id:                       ID of an existant certificate.
```
EOD
  type = map(object({
    certificate_file                    = optional(string)
    certificate_password                = optional(string)
    certificate_keyvault_certificate_id = optional(string)
    certificate_id                      = optional(string)
  }))
  default = null
}

variable "app_service_vnet_integration_subnet_id" {
  description = "Id of the subnet to associate with the app service"
  type        = string
  default     = null
}

variable "staging_slot_app_settings" {
  type        = map(string)
  description = "Override staging slot with custom app settings"
  default     = null
}

variable "tags" {
  description = "Tags to add."
  type        = map(string)
  default     = {}
}

variable "extra_tags" {
  description = "Extra tags to add."
  type        = map(string)
  default     = {}
}
