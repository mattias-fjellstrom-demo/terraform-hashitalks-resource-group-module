// -----------------------------------------------------------------------------
// CONFIGURE PROVIDERS
// -----------------------------------------------------------------------------
provider "azurerm" {
  features {}
}

// -----------------------------------------------------------------------------
// GLOBAL VARIABLES
// -----------------------------------------------------------------------------
variables {
  name_suffix = "test"
  location    = "swedencentral"
}

// -----------------------------------------------------------------------------
// TESTS FOR OUTPUTS
// -----------------------------------------------------------------------------
run "output_should_contain_required_properties" {
  command = apply

  assert {
    condition     = lookup(output.resource_group, "id", null) != null
    error_message = "Output did not have an ID field"
  }

  assert {
    condition     = lookup(output.resource_group, "name", null) != null
    error_message = "Output did not have a name field"
  }

  assert {
    condition     = lookup(output.resource_group, "location", null) != null
    error_message = "Output did not have a location field"
  }

  assert {
    condition     = lookup(output.resource_group, "tags", null) != null
    error_message = "Output did not have a tags field"
  }

  assert {
    condition     = lookup(output.resource_group.tags, "managed_by", null) == "terraform"
    error_message = "Output did not have a tags field"
  }
}