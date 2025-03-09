resource "azurerm_service_plan" "plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type            = var.os_type
  sku_name           = var.sku_name

  tags = var.tags
}

resource "azurerm_linux_web_app" "app" {
  count = var.os_type == "Linux" ? 1 : 0

  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      docker_image     = var.docker_image
      docker_image_tag = var.docker_image_tag
    }
  }

  app_settings = var.app_settings

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_windows_web_app" "app" {
  count = var.os_type == "Windows" ? 1 : 0

  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {}

  app_settings = var.app_settings

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
} 