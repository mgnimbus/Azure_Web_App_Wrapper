
app_service_plan_name = "test_app_servive_plan"
location              = "CentralIndia"
resource_group_name   = "app-service-test-ind"
os_type               = "Linux"
sku_name              = "P1v3"

app_service_name     = "linux-test-web-app"
backup_enabled       = false
staging_slot_enabled = false

tags = {
  ProjectName  = "demo-internal"
  Env          = "dev"
  Owner        = "user@example.com"
  BusinessUnit = "CORP"
  ServiceClass = "Gold"
  Sourve       = "Terraform"
}
