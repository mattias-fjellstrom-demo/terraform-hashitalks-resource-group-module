resource "azurerm_resource_group" "this" {
  name     = "rg-${var.name_suffix}"
  location = var.location

  tags = merge(var.tags, {
    managed_by = "terraform"
    project    = "hashitalks"
    location   = var.location
  })
}
