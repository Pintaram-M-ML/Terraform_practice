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