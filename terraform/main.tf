
resource "azurerm_resource_group" "rg" {
  name     = "fullstack-rg"
  location = "Central India"
}


resource "azurerm_service_plan" "plan" {
  name                = "fullstack-service-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "S1" 
}

resource "azurerm_linux_web_app" "app" {
  name                = "fullstack-app1603"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.plan.location
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      node_version = "18-lts"
    }
  }

  app_settings = {
    "PORT"                     = "8080"
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    "WEBSITE_RUN_FROM_PACKAGE" = "0"
  }

  https_only = true
}

resource "azurerm_linux_web_app_slot" "staging" {
  name                 = "staging"
  app_service_id       = azurerm_linux_web_app.app.id


  site_config {
    application_stack {
      node_version = "18-lts"
    }
  }

  app_settings = {
    "PORT"                     = "8080"
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    "WEBSITE_RUN_FROM_PACKAGE" = "0"
  }

  https_only = true
}

# Output URLs
output "production_url" {
  value = azurerm_linux_web_app.app.default_hostname
}

output "staging_url" {
  value = azurerm_linux_web_app_slot.staging.default_hostname
}
