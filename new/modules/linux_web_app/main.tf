resource "azurerm_application_insights" "app_insights" {
  count = var.application_insights_enabled && var.application_insights_id == null ? 1 : 0

  name                = var.application_insights_name
  resource_group_name = var.resource_group_name
  location            = var.location

  application_type    = var.application_insights_type
  sampling_percentage = var.application_insights_sampling_percentage
  retention_in_days   = var.application_insights_retention_in_days

  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled

  tags = var.tags
}

resource "azurerm_storage_container" "storcont" {
  count                 = var.backup_enabled ? 1 : 0
  name                  = var.storage_container_name == null ? "appservice-backup" : var.storage_container_name
  storage_account_name  = data.azurerm_storage_account.storeacc.0.name
  container_access_type = "private"
}

resource "azurerm_linux_web_app" "app_service_linux" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id

  dynamic "site_config" {
    for_each = [var.site_config]

    content {
      linux_fx_version = lookup(site_config.value, "linux_fx_version", null)

      always_on                = lookup(site_config.value, "always_on", null)
      app_command_line         = lookup(site_config.value, "app_command_line", null)
      default_documents        = lookup(site_config.value, "default_documents", null)
      ftps_state               = lookup(site_config.value, "ftps_state", "Disabled")
      health_check_path        = lookup(site_config.value, "health_check_path", null)
      http2_enabled            = lookup(site_config.value, "http2_enabled", null)
      local_mysql_enabled      = lookup(site_config.value, "local_mysql_enabled", false)
      managed_pipeline_mode    = lookup(site_config.value, "managed_pipeline_mode", null)
      minimum_tls_version      = lookup(site_config.value, "minimum_tls_version", lookup(site_config.value, "min_tls_version", "1.2"))
      remote_debugging_enabled = lookup(site_config.value, "remote_debugging_enabled", false)
      remote_debugging_version = lookup(site_config.value, "remote_debugging_version", null)
      use_32_bit_worker        = lookup(site_config.value, "use_32_bit_worker", false)
      websockets_enabled       = lookup(site_config.value, "websockets_enabled", false)

      load_balancing_mode                           = lookup(site_config.value, "load_balancing_mode", null)
      api_definition_url                            = lookup(site_config.value, "api_definition_url", null)
      api_management_api_id                         = lookup(site_config.value, "api_management_api_id", null)
      container_registry_managed_identity_client_id = lookup(site_config.value, "container_registry_managed_identity_client_id", null)
      container_registry_use_managed_identity       = lookup(site_config.value, "container_registry_use_managed_identity", null)
      worker_count                                  = lookup(site_config.value, "worker_count", null)

      dynamic "ip_restriction" {
        for_each = lookup(site_config.value, "ip_restriction", [])
        content {
          action      = lookup(local.site_config.application_stack, "action", null)
          ip_address  = lookup(local.site_config.application_stack, "ip_address", null)
          name        = lookup(local.site_config.application_stack, "name", null)
          priority    = lookup(local.site_config.application_stack, "priority", null)
          service_tag = lookup(local.site_config.application_stack, "service_tag", null)
          headers     = local.ip_restriction_headers

          virtual_network_subnet_id = lookup(local.site_config.application_stack, "virtual_network_subnet_id", null)
        }
      }
      scm_type                    = lookup(site_config.value, "scm_type", null)
      scm_use_main_ip_restriction = lookup(site_config.value, "scm_use_main_ip_restriction", false)

      vnet_route_all_enabled = var.app_service_vnet_integration_subnet_id != null
      dynamic "scm_ip_restriction" {
        for_each = lookup(site_config.value, "scm_ip_restriction", [])
        content {
          action      = lookup(local.site_config.application_stack, "action", null)
          ip_address  = lookup(local.site_config.application_stack, "ip_address", null)
          name        = lookup(local.site_config.application_stack, "name", null)
          priority    = lookup(local.site_config.application_stack, "priority", null)
          service_tag = lookup(local.site_config.application_stack, "service_tag", null)
          headers     = local.scm_ip_restriction_headers

          virtual_network_subnet_id = lookup(local.site_config.application_stack, "virtual_network_subnet_id", null)
        }
      }


      dynamic "application_stack" {
        for_each = lookup(site_config.value, "application_stack", null) == null ? [] : ["application_stack"]
        content {
          docker_image     = lookup(local.site_config.application_stack, "docker_image", null)
          docker_image_tag = lookup(local.site_config.application_stack, "docker_image_tag", null)
          go_version       = lookup(local.site_config.application_stack, "go_version", null)

          dotnet_version      = lookup(local.site_config.application_stack, "dotnet_version", null)
          java_server         = lookup(local.site_config.application_stack, "java_server", null)
          java_server_version = lookup(local.site_config.application_stack, "java_server_version", null)
          java_version        = lookup(local.site_config.application_stack, "java_version", null)
          node_version        = lookup(local.site_config.application_stack, "node_version", null)
          php_version         = lookup(local.site_config.application_stack, "php_version", null)
          python_version      = lookup(local.site_config.application_stack, "python_version", null)
          ruby_version        = lookup(local.site_config.application_stack, "ruby_version", null)
        }
      }

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", [])
        content {
          allowed_origins     = cors.value.allowed_origins
          support_credentials = lookup(cors.value, "support_credentials", null)
        }
      }
    }
  }

  app_settings = local.app_settings

  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = lookup(connection_string.value, "name", null)
      type  = lookup(connection_string.value, "type", null)
      value = lookup(connection_string.value, "value", null)
    }
  }

  dynamic "sticky_settings" {
    for_each = var.sticky_settings == null ? [] : [var.sticky_settings]
    content {
      app_setting_names       = sticky_settings.value.app_setting_names
      connection_string_names = sticky_settings.value.connection_string_names
    }
  }

  auth_settings {
    enabled                        = local.auth_settings.enabled
    issuer                         = local.auth_settings.issuer
    token_store_enabled            = local.auth_settings.token_store_enabled
    unauthenticated_client_action  = local.auth_settings.unauthenticated_client_action
    default_provider               = local.auth_settings.default_provider
    allowed_external_redirect_urls = local.auth_settings.allowed_external_redirect_urls

    dynamic "active_directory" {
      for_each = local.auth_settings_active_directory.client_id == null ? [] : [local.auth_settings_active_directory]
      content {
        client_id         = local.auth_settings_active_directory.client_id
        client_secret     = local.auth_settings_active_directory.client_secret
        allowed_audiences = concat(formatlist("https://%s", [format("%s.azurewebsites.net", local.app_service_name)]), local.auth_settings_active_directory.allowed_audiences)
      }
    }
  }

  client_affinity_enabled    = var.client_affinity_enabled
  client_certificate_enabled = var.client_certificate_enabled
  https_only                 = var.https_only

  dynamic "identity" {
    for_each = var.identity
    content {
      type         = lookup(identity.value, "type", null)
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }
  key_vault_reference_identity_id = var.key_vault_reference_identity_id
  dynamic "backup" {
    for_each = var.backup_enabled ? [{}] : []
    content {
      name                = coalesce(var.backup_settings.name, "DefaultBackup")
      storage_account_url = format("https://${data.azurerm_storage_account.storeacc.0.name}.blob.core.windows.net/${azurerm_storage_container.storcont.0.name}%s", data.azurerm_storage_account_blob_container_sas.main.0.sas)
      enabled             = var.backup_settings.enabled

      schedule {
        frequency_interval    = var.backup_settings.frequency_interval
        frequency_unit        = var.backup_settings.frequency_unit
        retention_period_days = var.backup_settings.retention_period_in_days
        start_time            = var.backup_settings.start_time
      }
    }
  }

  dynamic "storage_account" {
    for_each = var.mount_points
    content {
      name         = lookup(storage_account.value, "name", format("%s-%s", storage_account.value["account_name"], storage_account.value["share_name"]))
      type         = lookup(storage_account.value, "type", "AzureFiles")
      account_name = lookup(storage_account.value, "account_name", null)
      share_name   = lookup(storage_account.value, "share_name", null)
      access_key   = lookup(storage_account.value, "access_key", null)
      mount_path   = lookup(storage_account.value, "mount_path", null)
    }
  }

  dynamic "logs" {
    for_each = var.app_service_logs == null ? [] : [var.app_service_logs]
    content {
      detailed_error_messages = lookup(logs.value, "detailed_error_messages", null)
      failed_request_tracing  = lookup(logs.value, "failed_request_tracing", null)

      dynamic "application_logs" {
        for_each = lookup(logs.value, "application_logs", null) == null ? [] : ["application_logs"]

        content {
          dynamic "azure_blob_storage" {
            for_each = lookup(logs.value["application_logs"], "azure_blob_storage", null) == null ? [] : ["azure_blob_storage"]
            content {
              level             = lookup(logs.value["application_logs"]["azure_blob_storage"], "level", null)
              retention_in_days = lookup(logs.value["application_logs"]["azure_blob_storage"], "retention_in_days", null)
              sas_url           = lookup(logs.value["application_logs"]["azure_blob_storage"], "sas_url", null)
            }
          }
          file_system_level = lookup(logs.value["application_logs"], "file_system_level", null)
        }
      }

      dynamic "http_logs" {
        for_each = lookup(logs.value, "http_logs", null) == null ? [] : ["http_logs"]
        content {
          dynamic "azure_blob_storage" {
            for_each = lookup(logs.value["http_logs"], "azure_blob_storage", null) == null ? [] : ["azure_blob_storage"]
            content {
              retention_in_days = lookup(logs.value["http_logs"]["azure_blob_storage"], "retention_in_days", null)
              sas_url           = lookup(logs.value["http_logs"]["azure_blob_storage"], "sas_url", null)
            }
          }
          dynamic "file_system" {
            for_each = lookup(logs.value["http_logs"], "file_system", null) == null ? [] : ["file_system"]
            content {
              retention_in_days = lookup(logs.value["http_logs"]["file_system"], "retention_in_days", null)
              retention_in_mb   = lookup(logs.value["http_logs"]["file_system"], "retention_in_mb", null)
            }
          }
        }
      }
    }
  }

  tags = merge(var.tags, var.extra_tags)

  lifecycle {
    ignore_changes = [
      backup[0].storage_account_url,
      virtual_network_subnet_id,
    ]
  }
}

resource "azurerm_linux_web_app_slot" "app_service_linux_slot" {
  count = var.staging_slot_enabled ? 1 : 0

  name           = local.staging_slot_name
  app_service_id = azurerm_linux_web_app.app_service_linux.id

  dynamic "site_config" {
    for_each = [var.site_config]
    content {
      linux_fx_version = lookup(site_config.value, "linux_fx_version", null)

      always_on                = lookup(site_config.value, "always_on", null)
      app_command_line         = lookup(site_config.value, "app_command_line", null)
      default_documents        = lookup(site_config.value, "default_documents", null)
      ftps_state               = lookup(site_config.value, "ftps_state", "Disabled")
      health_check_path        = lookup(site_config.value, "health_check_path", null)
      http2_enabled            = lookup(site_config.value, "http2_enabled", null)
      local_mysql_enabled      = lookup(site_config.value, "local_mysql_enabled", false)
      managed_pipeline_mode    = lookup(site_config.value, "managed_pipeline_mode", null)
      minimum_tls_version      = lookup(site_config.value, "minimum_tls_version", lookup(site_config.value, "min_tls_version", "1.2"))
      remote_debugging_enabled = lookup(site_config.value, "remote_debugging_enabled", false)
      remote_debugging_version = lookup(site_config.value, "remote_debugging_version", null)
      use_32_bit_worker        = lookup(site_config.value, "use_32_bit_worker", false)
      websockets_enabled       = lookup(site_config.value, "websockets_enabled", false)

      load_balancing_mode                           = lookup(site_config.value, "load_balancing_mode", null)
      api_definition_url                            = lookup(site_config.value, "api_definition_url", null)
      api_management_api_id                         = lookup(site_config.value, "api_management_api_id", null)
      container_registry_managed_identity_client_id = lookup(site_config.value, "container_registry_managed_identity_client_id", null)
      container_registry_use_managed_identity       = lookup(site_config.value, "container_registry_use_managed_identity", null)
      worker_count                                  = lookup(site_config.value, "worker_count", null)

      dynamic "ip_restriction" {
        for_each = lookup(site_config.value, "ip_restriction", [])
        content {
          action      = lookup(local.site_config.application_stack, "action", null)
          ip_address  = lookup(local.site_config.application_stack, "ip_address", null)
          name        = lookup(local.site_config.application_stack, "name", null)
          priority    = lookup(local.site_config.application_stack, "priority", null)
          service_tag = lookup(local.site_config.application_stack, "service_tag", null)
          headers     = local.ip_restriction_headers

          virtual_network_subnet_id = lookup(local.site_config.application_stack, "virtual_network_subnet_id", null)
        }
      }
      scm_type                    = lookup(site_config.value, "scm_type", null)
      scm_use_main_ip_restriction = lookup(site_config.value, "scm_use_main_ip_restriction", false)

      vnet_route_all_enabled = var.app_service_vnet_integration_subnet_id != null
      dynamic "scm_ip_restriction" {
        for_each = lookup(site_config.value, "scm_ip_restriction", [])
        content {
          action      = lookup(local.site_config.application_stack, "action", null)
          ip_address  = lookup(local.site_config.application_stack, "ip_address", null)
          name        = lookup(local.site_config.application_stack, "name", null)
          priority    = lookup(local.site_config.application_stack, "priority", null)
          service_tag = lookup(local.site_config.application_stack, "service_tag", null)
          headers     = local.scm_ip_restriction_headers

          virtual_network_subnet_id = lookup(local.site_config.application_stack, "virtual_network_subnet_id", null)
        }
      }

      dynamic "application_stack" {
        for_each = lookup(site_config.value, "application_stack", null) == null ? [] : ["application_stack"]
        content {
          docker_image     = lookup(local.site_config.application_stack, "docker_image", null)
          docker_image_tag = lookup(local.site_config.application_stack, "docker_image_tag", null)
          go_version       = lookup(local.site_config.application_stack, "go_version", null)

          dotnet_version      = lookup(local.site_config.application_stack, "dotnet_version", null)
          java_server         = lookup(local.site_config.application_stack, "java_server", null)
          java_server_version = lookup(local.site_config.application_stack, "java_server_version", null)
          java_version        = lookup(local.site_config.application_stack, "java_version", null)
          node_version        = lookup(local.site_config.application_stack, "node_version", null)
          php_version         = lookup(local.site_config.application_stack, "php_version", null)
          python_version      = lookup(local.site_config.application_stack, "python_version", null)
          ruby_version        = lookup(local.site_config.application_stack, "ruby_version", null)
        }
      }

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", [])
        content {
          allowed_origins     = cors.value.allowed_origins
          support_credentials = lookup(cors.value, "support_credentials", null)
        }
      }
    }
  }

  app_settings = var.staging_slot_app_settings == null ? local.app_settings : merge(local.default_app_settings, var.staging_slot_app_settings)

  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = lookup(connection_string.value, "name", null)
      type  = lookup(connection_string.value, "type", null)
      value = lookup(connection_string.value, "value", null)
    }
  }

  auth_settings {
    enabled                        = local.auth_settings.enabled
    issuer                         = local.auth_settings.issuer
    token_store_enabled            = local.auth_settings.token_store_enabled
    unauthenticated_client_action  = local.auth_settings.unauthenticated_client_action
    default_provider               = local.auth_settings.default_provider
    allowed_external_redirect_urls = local.auth_settings.allowed_external_redirect_urls

    dynamic "active_directory" {
      for_each = local.auth_settings_active_directory.client_id == null ? [] : [local.auth_settings_active_directory]
      content {
        client_id         = local.auth_settings_active_directory.client_id
        client_secret     = local.auth_settings_active_directory.client_secret
        allowed_audiences = concat(formatlist("https://%s", [format("%s.azurewebsites.net", local.app_service_name)]), local.auth_settings_active_directory.allowed_audiences)
      }
    }
  }

  client_affinity_enabled = var.client_affinity_enabled
  https_only              = var.https_only

  dynamic "identity" {
    for_each = var.identity
    content {
      type         = lookup(identity.value, "type", null)
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }
  key_vault_reference_identity_id = var.key_vault_reference_identity_id

  dynamic "storage_account" {
    for_each = var.mount_points
    content {
      name         = lookup(storage_account.value, "name", format("%s-%s", storage_account.value["account_name"], storage_account.value["share_name"]))
      type         = lookup(storage_account.value, "type", "AzureFiles")
      account_name = lookup(storage_account.value, "account_name", null)
      share_name   = lookup(storage_account.value, "share_name", null)
      access_key   = lookup(storage_account.value, "access_key", null)
      mount_path   = lookup(storage_account.value, "mount_path", null)
    }
  }

  dynamic "logs" {
    for_each = var.app_service_logs == null ? [] : [var.app_service_logs]
    content {
      detailed_error_messages = lookup(logs.value, "detailed_error_messages", null)
      failed_request_tracing  = lookup(logs.value, "failed_request_tracing", null)

      dynamic "application_logs" {
        for_each = lookup(logs.value, "application_logs", null) == null ? [] : ["application_logs"]

        content {
          dynamic "azure_blob_storage" {
            for_each = lookup(logs.value["application_logs"], "azure_blob_storage", null) == null ? [] : ["azure_blob_storage"]
            content {
              level             = lookup(logs.value["application_logs"]["azure_blob_storage"], "level", null)
              retention_in_days = lookup(logs.value["application_logs"]["azure_blob_storage"], "retention_in_days", null)
              sas_url           = lookup(logs.value["application_logs"]["azure_blob_storage"], "sas_url", null)
            }
          }
          file_system_level = lookup(logs.value["application_logs"], "file_system_level", null)
        }
      }

      dynamic "http_logs" {
        for_each = lookup(logs.value, "http_logs", null) == null ? [] : ["http_logs"]
        content {
          dynamic "azure_blob_storage" {
            for_each = lookup(logs.value["http_logs"], "azure_blob_storage", null) == null ? [] : ["azure_blob_storage"]
            content {
              retention_in_days = lookup(logs.value["http_logs"]["azure_blob_storage"], "retention_in_days", null)
              sas_url           = lookup(logs.value["http_logs"]["azure_blob_storage"], "sas_url", null)
            }
          }
          dynamic "file_system" {
            for_each = lookup(logs.value["http_logs"], "file_system", null) == null ? [] : ["file_system"]
            content {
              retention_in_days = lookup(logs.value["http_logs"]["file_system"], "retention_in_days", null)
              retention_in_mb   = lookup(logs.value["http_logs"]["file_system"], "retention_in_mb", null)
            }
          }
        }
      }
    }
  }

  tags = merge(var.tags, var.extra_tags)

  lifecycle {
    ignore_changes = [
      virtual_network_subnet_id,
    ]
  }
}

resource "azurerm_app_service_certificate" "app_service_certificate" {
  for_each = var.custom_domains != null ? {
    for k, v in var.custom_domains :
    k => v if try(v.certificate_id == null, false)
  } : {}

  name                = each.value.certificate_file != null ? basename(each.value.certificate_file) : split("/", each.value.certificate_keyvault_certificate_id)[4]
  resource_group_name = var.resource_group_name
  location            = var.location
  pfx_blob            = each.value.certificate_file != null ? filebase64(each.value.certificate_file) : null
  password            = each.value.certificate_password
  key_vault_secret_id = each.value.certificate_keyvault_certificate_id
}

resource "azurerm_app_service_custom_hostname_binding" "app_service_custom_hostname_binding" {
  for_each = toset(var.custom_domains != null ? keys(var.custom_domains) : [])

  hostname            = each.key
  app_service_name    = azurerm_linux_web_app.app_service_linux.name
  resource_group_name = var.resource_group_name
  ssl_state           = lookup(azurerm_app_service_certificate.app_service_certificate, each.key, null) != null ? "SniEnabled" : null
  thumbprint          = lookup(azurerm_app_service_certificate.app_service_certificate, each.key, null) != null ? azurerm_app_service_certificate.app_service_certificate[each.key].thumbprint : try(data.azurerm_app_service_certificate.certificate[each.key].thumbprint, null)
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_service_vnet_integration" {
  count          = var.app_service_vnet_integration_subnet_id == null ? 0 : 1
  app_service_id = azurerm_linux_web_app.app_service_linux.id
  subnet_id      = var.app_service_vnet_integration_subnet_id
}

resource "azurerm_app_service_slot_virtual_network_swift_connection" "app_service_slot_vnet_integration" {
  count          = var.staging_slot_enabled && var.app_service_vnet_integration_subnet_id != null ? 1 : 0
  slot_name      = azurerm_linux_web_app_slot.app_service_linux_slot[0].name
  app_service_id = azurerm_linux_web_app.app_service_linux.id
  subnet_id      = var.app_service_vnet_integration_subnet_id
}
