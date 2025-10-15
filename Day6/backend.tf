terraform {
     backend "azurerm" {
    resource_group_name  = "tfstate-day04"
    storage_account_name = "day0417363"  # must exactly match Azure
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}