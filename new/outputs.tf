#service_plan
output "service_plan_id" {
  description = "ID of the created Service Plan"
  value       = azurerm_service_plan.appserviceplan.id
}

output "service_plan_name" {
  description = "Name of the created Service Plan"
  value       = azurerm_service_plan.appserviceplan.name
}

output "service_plan_location" {
  description = "Azure location of the created Service Plan"
  value       = azurerm_service_plan.appserviceplan.location
}

#Linux_web_app
output "app_service_linux" {
  description = "App Service Linux (Linux WebApp) output object if Linux is choosen. Please refer to `./modules/linux-web-app/README.md`"
  value       = try(module.linux_web_app["enabled"], null)
}

output "app_service_windows" {
  description = "App Service Windows (Windows WebApp) output object if Windows is choosen. Please refer to `./modules/windows-web-app/README.md`"
  value       = try(module.windows_web_app["enabled"], null)
}
