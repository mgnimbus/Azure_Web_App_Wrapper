provider "azurerm" {
  skip_provider_registration = true
  features {

  }
}

resource "azurerm_service_plan" "appserviceplan" {
  name                         = var.app_service_plan_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  os_type                      = var.os_type
  sku_name                     = var.sku_name
  worker_count                 = var.sku_name == "Y1" ? null : var.worker_count
  maximum_elastic_worker_count = var.maximum_elastic_worker_count
  app_service_environment_id   = var.app_service_environment_id
  per_site_scaling_enabled     = var.per_site_scaling_enabled
  zone_balancing_enabled       = var.zone_balancing_enabled
  tags                         = var.tags
}

module "linux_web_app" {
  for_each = toset(lower(var.os_type) == "linux" ? ["enabled"] : [])

  source              = "./modules/linux_web_app"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_name    = var.app_service_name
  service_plan_id     = azurerm_service_plan.appserviceplan.id

  app_settings       = var.app_settings
  site_config        = var.site_config
  auth_settings      = var.auth_settings
  connection_strings = var.connection_strings
  sticky_settings    = var.sticky_settings

  mount_points               = var.mount_points
  client_affinity_enabled    = var.client_affinity_enabled
  https_only                 = var.https_only
  client_certificate_enabled = var.client_certificate_enabled

  staging_slot_enabled      = var.staging_slot_enabled
  staging_slot_name         = var.staging_slot_name
  staging_slot_app_settings = var.staging_slot_app_settings

  custom_domains             = var.custom_domains
  ip_restriction_headers     = var.ip_restriction_headers
  scm_ip_restriction_headers = var.scm_ip_restriction_headers

  app_service_vnet_integration_subnet_id = var.app_service_vnet_integration_subnet_id

  backup_enabled                  = var.backup_enabled
  backup_name                     = var.backup_name
  backup_frequency_interval       = var.backup_frequency_interval
  backup_retention_period_in_days = var.backup_retention_period_in_days
  backup_frequency_unit           = var.backup_frequency_unit
  backup_keep_at_least_one_backup = var.backup_keep_at_least_one_backup

  application_insights_enabled             = var.application_insights_enabled
  application_insights_name                = var.application_insights_name
  application_insights_id                  = var.application_insights_id
  application_insights_sampling_percentage = var.application_insights_sampling_percentage
  application_insights_type                = var.application_insights_type
  tags                                     = var.tags
  extra_tags                               = var.extra_tags
}

module "container_web_app" {
  for_each = toset(lower(var.os_type) == "container" ? ["enabled"] : [])

  source = "./modules/container_web_app"

  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_name    = var.app_service_name
  service_plan_id     = azurerm_service_plan.appserviceplan.id
  docker_image        = var.docker_image

  app_settings       = var.app_settings
  site_config        = var.site_config
  auth_settings      = var.auth_settings
  connection_strings = var.connection_strings
  sticky_settings    = var.sticky_settings

  mount_points               = var.mount_points
  client_affinity_enabled    = var.client_affinity_enabled
  https_only                 = var.https_only
  client_certificate_enabled = var.client_certificate_enabled

  staging_slot_enabled      = var.staging_slot_enabled
  staging_slot_name         = var.staging_slot_name
  staging_slot_app_settings = var.staging_slot_app_settings

  custom_domains             = var.custom_domains
  ip_restriction_headers     = var.ip_restriction_headers
  scm_ip_restriction_headers = var.scm_ip_restriction_headers

  app_service_vnet_integration_subnet_id = var.app_service_vnet_integration_subnet_id

  backup_enabled                  = var.backup_enabled
  backup_name                     = var.backup_name
  backup_frequency_interval       = var.backup_frequency_interval
  backup_retention_period_in_days = var.backup_retention_period_in_days
  backup_frequency_unit           = var.backup_frequency_unit
  backup_keep_at_least_one_backup = var.backup_keep_at_least_one_backup

  application_insights_enabled             = var.application_insights_enabled
  application_insights_name                = var.application_insights_name
  application_insights_id                  = var.application_insights_id
  application_insights_sampling_percentage = var.application_insights_sampling_percentage
  application_insights_type                = var.application_insights_type
  tags                                     = var.tags
  extra_tags                               = var.extra_tags
}


module "windows_web_app" {
  for_each = toset(lower(var.os_type) == "windows" ? ["enabled"] : [])

  source = "./modules/windows_web_app"

  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_name    = var.app_service_name
  service_plan_id     = azurerm_service_plan.appserviceplan.id

  app_settings       = var.app_settings
  site_config        = var.site_config
  auth_settings      = var.auth_settings
  connection_strings = var.connection_strings
  sticky_settings    = var.sticky_settings

  mount_points               = var.mount_points
  client_affinity_enabled    = var.client_affinity_enabled
  https_only                 = var.https_only
  client_certificate_enabled = var.client_certificate_enabled

  staging_slot_enabled      = var.staging_slot_enabled
  staging_slot_name         = var.staging_slot_name
  staging_slot_app_settings = var.staging_slot_app_settings

  custom_domains             = var.custom_domains
  ip_restriction_headers     = var.ip_restriction_headers
  scm_ip_restriction_headers = var.scm_ip_restriction_headers

  app_service_vnet_integration_subnet_id = var.app_service_vnet_integration_subnet_id

  backup_enabled                  = var.backup_enabled
  backup_name                     = var.backup_name
  backup_frequency_interval       = var.backup_frequency_interval
  backup_retention_period_in_days = var.backup_retention_period_in_days
  backup_frequency_unit           = var.backup_frequency_unit
  backup_keep_at_least_one_backup = var.backup_keep_at_least_one_backup

  application_insights_enabled             = var.application_insights_enabled
  application_insights_name                = var.application_insights_name
  application_insights_id                  = var.application_insights_id
  application_insights_sampling_percentage = var.application_insights_sampling_percentage
  application_insights_type                = var.application_insights_type
  tags                                     = var.tags
  extra_tags                               = var.extra_tags
}
