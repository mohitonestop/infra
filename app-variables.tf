#############################
## Application - Variables ##
#############################

# company name 
variable "company" {
  type        = string
  description = "This variable defines thecompany name used to build resources"
}

# application name 
variable "az_app_name" {
  type        = string
  description = "This variable defines the application name used to build resources"
}

# environment
variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
}

# azure location
variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "EASTUS"
}

# azure region shortname
variable "region" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "eastus"
}

# owner
variable "owner" {
  type        = string
  description = "Specify the owner of the resource"
}

# description
variable "description" {
  type        = string
  description = "Provide a description of the resource"
}

# db user 
variable "db_user" {
  type        = string
  description = "This variable defines the db user"
}

# db password 
variable "db_pass" {
  type        = string
  description = "This variable defines the db password"
}

# db host 
variable "db_host" {
  type        = string
  description = "This variable defines the db host"
}


# db name 
variable "db_name" {
  type        = string
  description = "This variable defines the db name"
}

#plugin_db_name
variable "plugin_db_name" {
  type        = string
  description = "This variable defines the plugin db name"
}


#deployment_package
variable "deployment_package" {
  type        = string
  description = "This variable defines the wordpress zip file path"
}


# azure resource group shortname
variable "az_rg" {
  type        = string
  description = "Azure resource group where the resource will be created"
}


# azure service plan shortname
variable "az_sp" {
  type        = string
  description = "Azure Service plan where the App service will be created"
}

# Service Principal Variables

variable "client_id" {
    description =   "Client ID (APP ID) of the application"
    type        =   string
}

variable "client_secret" {
    description =   "Client Secret (Password) of the application"
    type        =   string
}

variable "subscription_id" {
    description =   "Subscription ID"
    type        =   string
}

variable "tenant_id" {
    description =   "Tenant ID"
    type        =   string
}