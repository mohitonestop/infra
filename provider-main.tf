###########################
## Azure Provider - Main ##
###########################

# Define Terraform provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.90.0"
    }
  }

# Define backend to store terraform statefile in azure blob
backend "azurerm" {
  resource_group_name  = "Infrastructure"
  storage_account_name = "datumtfstate"
  container_name       = "tfstate"
  key                  = "terraform.tfstate"
  #access_key           = "${env.ARM_ACCESS_KEY}"
}

}




provider "azurerm" {
  features {}
}
