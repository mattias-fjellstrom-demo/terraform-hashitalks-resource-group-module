output "resource_group" {
  value       = azurerm_resource_group.this
  description = "Resource group object"
}

output "resource_group_name" {
  value = azurerm_resource_group.this.name
}
