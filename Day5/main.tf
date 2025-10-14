terraform{
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.8.0"
    }
  }
    backend "azurerm" {
    resource_group_name  = "tfstate-day04"
    storage_account_name = "day0417363"  # must exactly match Azure
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_version = ">= 1.1.0" 
}
provider "azurerm" {
  features {}
  
}
variable "environment" {
  type = string
  description = "the env type"
  default = "dev"

}
# 'resource' is a Terraform keyword used to define something
# you want to create, update, or manage in your infrastructure.resource 

# "azurerm_resource_group" is the TYPE of resource.
# - 'azurerm' means it's from the Azure Resource Manager provider.
# - 'resource_group' is the specific Azure service (Resource Group).
#"azurerm_resource_group" 

# "example" is the NAME/label you give inside Terraform.
# - Terraform uses this internally to reference this resource.
# - It will not appear in Azure.
#"example"
# The block { ... } contains all the configuration details
# that describe how this resource should be created in Azure.
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "Central India"
}


# 'resource' tells Terraform you want to manage a resource.
#resource 

# "azurerm_storage_account" is the TYPE of resource.
# - 'azurerm' = from Azure Resource Manager provider.
# - 'storage_account' = an Azure Storage Account service.
#"azurerm_storage_account" 

# "example" is the Terraform NAME/label for this storage account.
# - Used only inside Terraform to reference it later (not shown in Azure).
#"example" 
# The block { ... } defines the configuration for this storage account.
resource "azurerm_storage_account" "example" {
  name                     = "pintaramstorage"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
    # 'account_replication_type' defines how data is copied for durability.
  # - "LRS" = Locally Redundant Storage (copies within one datacenter).
  # - "GRS" = Geo-Redundant Storage (copies across regions).
  # - "ZRS", "RAGRS", etc. are other options.

  account_replication_type = "LRS"

  # 'tags' are metadata (key-value pairs) you can attach.
  # Helpful for organizing, billing, and managing resources.
  tags = {
    environment = var.environment
  }

}
  output "storage_account_name"{
    value = azurerm_storage_account.example.name
  }


