variable "tags" {
  description = "Tags to add."
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
  description = "The SKU for the plan"
  type        = string
}


variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
  default     = "linux_web_app"
}

variable "site_config" {
  description = "Site config for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is no more managed in this block."
  type        = any
  default = {
    always_on = "true"
  }
}

variable "backup_enabled" {
  description = "`true` to enable App Service backup"
  type        = bool
  default     = true
}

variable "staging_slot_enabled" {
  type        = bool
  description = "Create a staging slot alongside the app service for blue/green deployment purposes. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_slot"
  default     = true
}
