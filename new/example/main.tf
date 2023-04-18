provider "azurerm" {
  skip_provider_registration = true
  features {
  }
}

module "linux_app" {
  source                       = "../"
  https_only                   = true
  application_insights_enabled = true
  backup_enabled               = true
  site_config = {
    minimum_tls_version = "1.2"
    ftps_state          = "FtpsOnly"
  }

  location            = var.location
  resource_group_name = var.resource_group_name

  app_service_plan_name = var.app_service_plan_name
  os_type               = var.os_type
  sku_name              = var.sku_name

  application_insights_name = var.application_insights_name
  app_service_name          = var.app_service_name
  storage_account_name      = var.storage_account_name
  storage_container_name    = var.storage_container_name

  backup_settings = {
    enabled                  = true
    name                     = "DefaultBackup"
    frequency_interval       = 30
    frequency_unit           = "Day"
    retention_period_in_days = 90
  }

  staging_slot_enabled = var.staging_slot_enabled
  identity = {
    one = {
      type = "SystemAssigned"
    }
  }
  tags = var.tags
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
