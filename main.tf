resource "azurerm_resource_group" "this" {
  name     = "rg-${var.name_suffix}"
  location = var.location

  tags = {
    managed_by = "terraform"
    location   = var.location
  }
}
