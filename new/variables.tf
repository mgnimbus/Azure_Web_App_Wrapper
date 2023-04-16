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

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = ""
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = ""
}

variable "app_service_plan_name" {
  description = "Specifies the name of the App Service Plan component"
  default     = ""
}

variable "os_type" {
  description = "The O/S type for the App Services to be hosted in this plan. Possible values include `Windows`, `Linux`, and `WindowsContainer`."
  type        = string

  validation {
    condition     = try(contains(["Windows", "Linux", "WindowsContainer"], var.os_type), true)
    error_message = "The `os_type` value must be valid. Possible values are `Windows`, `Linux`, and `WindowsContainer`."
  }
}

variable "sku_name" {
  description = "The SKU for the plan. Possible values include B1, B2, B3, D1, F1, FREE, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, Y1, EP1, EP2, EP3, WS1, WS2, and WS3."
  type        = string

  validation {
    condition     = try(contains(["B1", "B2", "B3", "D1", "F1", "FREE", "I1", "I2", "I3", "I1v2", "I2v2", "I3v2", "P1v2", "P2v2", "P3v2", "P1v3", "P2v3", "P3v3", "S1", "S2", "S3", "SHARED", "Y1", "EP1", "EP2", "EP3", "WS1", "WS2", "WS3"], var.sku_name), true)
    error_message = "The `sku_name` value must be valid. Possible values include B1, B2, B3, D1, F1, FREE, I1, I2, I3, I1v2, I2v2, I3v2, P1v2, P2v2, P3v2, P1v3, P2v3, P3v3, S1, S2, S3, SHARED, Y1, EP1, EP2, EP3, WS1, WS2, and WS3."
  }
}

variable "worker_count" {
  description = "The number of Workers (instances) to be allocated."
  type        = number
  default     = 3
}

variable "maximum_elastic_worker_count" {
  description = "The maximum number of workers to use in an Elastic SKU Plan. Cannot be set unless using an Elastic SKU."
  type        = number
  default     = null
}

variable "app_service_environment_id" {
  description = "The ID of the App Service Environment to create this Service Plan in. Requires an Isolated SKU. Use one of I1, I2, I3 for azurerm_app_service_environment, or I1v2, I2v2, I3v2 for azurerm_app_service_environment_v3"
  type        = string
  default     = null
}

variable "per_site_scaling_enabled" {
  description = "Should Per Site Scaling be enabled."
  type        = bool
  default     = false
}

variable "zone_balancing_enabled" {
  description = "Should the Service Plan balance across Availability Zones in the region."
  type        = bool
  default     = false

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

# variable "service_plan_id" {
#   description = "ID of the Service Plan that hosts the App Service"
#   type        = string
# }

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
  description = "Configuration of the App Service and App Service Slot logs. Documentation [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app#logs)"
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

variable "docker_image" {
  description = "Docker image to use for this App Service"
  type = object({
    name     = string
    tag      = string
    slot_tag = optional(string)
  })
  default = null
}
