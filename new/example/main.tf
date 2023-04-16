provider "azurerm" {
  skip_provider_registration = true
  features {

  }
}

module "linux_app" {
  source              = "../"
  location            = var.location
  resource_group_name = var.resource_group_name

  app_service_plan_name = var.app_service_plan_name
  os_type               = var.os_type
  sku_name              = var.sku_name

  app_service_name = var.app_service_name
  https_only       = true
  site_config = {
    minimum_tls_version = "1.2"
  }
  backup_enabled       = var.backup_enabled
  staging_slot_enabled = var.staging_slot_enabled
  tags                 = var.tags
}
