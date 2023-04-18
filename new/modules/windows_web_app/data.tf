data "azurerm_subscription" "current_subscription" {
}

data "azurerm_client_config" "main" {}

data "azurerm_application_insights" "app_insights" {
  count = var.application_insights_enabled && var.application_insights_id != null ? 1 : 0

  name                = split("/", var.application_insights_id)[8]
  resource_group_name = split("/", var.application_insights_id)[4]
}

data "azurerm_app_service_certificate" "certificate" {
  for_each = var.custom_domains != null ? {
    for k, v in var.custom_domains :
    k => v if try(v.certificate_id != null, false)
  } : {}

  name                = reverse(split("/", each.value.certificate_id))[0]
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "storeacc" {
  count               = var.backup_enabled ? 1 : 0
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account_blob_container_sas" "main" {
  count             = var.backup_enabled ? 1 : 0
  connection_string = data.azurerm_storage_account.storeacc.0.primary_connection_string
  container_name    = azurerm_storage_container.storcont.0.name
  https_only        = true

  start  = timestamp()
  expiry = time_rotating.main.0.rotation_rfc3339

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }

  cache_control       = "max-age=5"
  content_disposition = "inline"
  content_encoding    = "deflate"
  content_language    = "en-US"
  content_type        = "application/json"
}

resource "time_rotating" "main" {
  count            = var.backup_enabled ? 1 : 0
  rotation_rfc3339 = var.password_end_date
  rotation_years   = var.password_rotation_in_years

  triggers = {
    end_date = var.password_end_date
    years    = var.password_rotation_in_years
  }
}
