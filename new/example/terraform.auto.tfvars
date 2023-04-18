location            = "CentralIndia"
resource_group_name = "app-service-test-ind"
os_type             = "Linux"
sku_name            = "B2"

application_insights_name = "test_insights_web_app"
app_service_plan_name     = "test_app_servive_plan"
app_service_name          = "linux-test-web-app"

storage_account_name   = "webappbackuptest007"
storage_container_name = "appservice-backup"
staging_slot_enabled   = false

tags = {
  ProjectName  = "demo-internal"
  Env          = "dev"
  Owner        = "user@example.com"
  BusinessUnit = "CORP"
  ServiceClass = "Gold"
  Sourve       = "Terraform"
}
