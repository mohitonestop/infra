##############################
## Azure App Service - Main ##
##############################

# Create a Resource Group
resource "azurerm_resource_group" "appservice-rg" {
  name     = "${var.az_rg}"
  location = var.location

  tags = {
    description = var.description
    environment = var.environment
    owner       = var.owner  
  }
}

# Create the App Service Plan
resource "azurerm_app_service_plan" "service-plan" {
  name                = "${var.az_sp}"
  location            = azurerm_resource_group.appservice-rg.location
  resource_group_name = azurerm_resource_group.appservice-rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    description = var.description
    environment = var.environment
    owner       = var.owner  
  }
}

# Create the App Service
resource "azurerm_app_service" "app-service" {
  name                = "${var.az_app_name}1008"
  location            = azurerm_resource_group.appservice-rg.location
  resource_group_name = azurerm_resource_group.appservice-rg.name
  app_service_plan_id = azurerm_app_service_plan.service-plan.id

  site_config {
    dotnet_framework_version = "v4.0"
    #scm_type                = "LocalGit"
    #scm_type                 = "ExternalGit"
    linux_fx_version         = "PHP|7.4"
  }
  
 # source_control {
 #   repo_url = "https://github.com/azureappserviceoss/wordpress-azure"
 #   branch = "master"
 # }
  
  connection_string {
    name  = "defaultConnection"
    type  = "MySQL"
    value = "Database=$(var.db_name); Data Source=${var.db_host}.mysql.database.azure.com;User Id=${var.db_user}@${var.db_host}.mysql.database.azure.com;Password=${var.db_pass}"
  }
  
  tags = {
    description = var.description
    environment = var.environment
    owner       = var.owner  
  }
}

resource "azurerm_mysql_database" "DB" {
  name                = "${var.db_name}1008"
  resource_group_name = "ResWP"
  server_name         = "${var.db_host}"
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

#resource "azurerm_mysql_database" "PLUGIN_DB" {
#  name                = $(var.plugin_db_name)
#  resource_group_name = "ResWP"
#  server_name         = ${var.db_host}
#  charset             = "utf8"
#  collation           = "utf8_unicode_ci"
#}

resource "null_resource" "webjob" {
  provisioner "local-exec" {
    when = create   
    command = "azurerm webapp deployment source config-zip -g azurerm_resource_group.appservice-rg.name -n '${var.az_app_name}1008' --src '${var.az_app_path}'"

  }
  
  depends_on = [ azurerm_app_service.app-service ]
}
