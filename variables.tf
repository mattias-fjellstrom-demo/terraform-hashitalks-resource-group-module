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
    condition     = !can(regex("\\s+", var.name_suffix))
    error_message = "Name suffix should not contain whitespace characters"
  }

  validation {
    condition     = !startswith(var.name_suffix, "rg-")
    error_message = "Do not add 'rg-' in the name, this is added automatically"
  }

  validation {
    condition     = length("rg-${var.name_suffix}") <= 90
    error_message = "Name suffix is too long (should be at most 87 characters)"
  }
}

variable "tags" {
  type        = map(string)
  description = "Key/value tags to add to the resource group"

  validation {
    condition     = lookup(var.tags, "team", null) != null
    error_message = "Please include a 'team' tag with your team name"
  }

  validation {
    condition     = lookup(var.tags, "project", null) != null
    error_message = "Please include a 'project' tag with a project name"
  }

  validation {
    condition     = lookup(var.tags, "cost_center", null) != null
    error_message = "Please include a 'cost_center' tag with your cost center"
  }
}
