terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.80"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "location" {
  type = string

  validation {
    condition = contains([
      "swedencentral",
      "westeurope",
      "northeurope"
    ], var.location)
    error_message = "Use an approved location"
  }
}

variable "name_suffix" {
  type = string

  validation {
    condition     = !startswith(var.name_suffix, "rg-")
    error_message = "Do not use 'rg-' in the name suffix, this is added automatically"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${name_suffix}"
  location = var.location
}

output "resource_group" {
  value = azurerm_resource_group.this
}
