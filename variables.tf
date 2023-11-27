variable "location" {
  type        = string
  default     = "swedencentral"
  description = "Azure location for resource group"

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
  type        = string
  description = "Resource group name suffix (i.e. rg-<NAME_SUFFIX>)"

  validation {
    condition     = !startswith(var.name_suffix, "rg-")
    error_message = "Do not add 'rg-' in the name, this is added automatically"
  }

  validation {
    condition     = length("rg-${var.name_suffix}") <= 90
    error_message = "Resource group name too long (should be between 1 and 90 characters)"
  }
}
