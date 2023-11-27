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
    error_message = "Do not add 'rg-' in the name, this is added automatically"
  }
}
