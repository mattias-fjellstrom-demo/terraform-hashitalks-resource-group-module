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
// TESTS FOR VARIABLES
// -----------------------------------------------------------------------------
run "should_not_allow_rg_prefix_in_name_suffix" {
  command = plan

  variables {
    name_suffix = "rg-test"
  }

  expect_failures = [
    var.name_suffix
  ]
}

run "should_not_allow_whitespace_in_name_suffix" {
  command = plan

  variables {
    name_suffix = "my name suffix"
  }

  expect_failures = [
    var.name_suffix
  ]
}

run "should_not_allow_invalid_location" {
  command = plan

  variables {
    location = "westus"
  }

  expect_failures = [
    var.location
  ]
}

run "should_not_allow_too_long_name_suffix" {
  command = plan

  variables {
    name_suffix = replace("**********", "*", "abcdefghij")
  }

  expect_failures = [
    var.name_suffix
  ]
}

// -----------------------------------------------------------------------------
// TESTS FOR RESOURCE PROPERTIES
// -----------------------------------------------------------------------------
run "should_set_correct_tags" {
  command = plan

  variables {
    tags     = { team = "hashitalks team" }
    location = "westeurope"
  }

  assert {
    condition     = lookup(azurerm_resource_group.this.tags, "team") == var.tags["team"]
    error_message = "The 'team' tag is not set correctly"
  }

  assert {
    condition     = lookup(azurerm_resource_group.this.tags, "managed_by") == "terraform"
    error_message = "The 'managed_by' tag is not set correctly"
  }

  assert {
    condition     = lookup(azurerm_resource_group.this.tags, "location") == var.location
    error_message = "The 'location' tag is not set correctly"
  }

  assert {
    condition     = lookup(azurerm_resource_group.this.tags, "project") == "hashitalks"
    error_message = "The 'project' tag is not set correctly"
  }
}

run "should_set_rg_name_prefix" {
  command = plan

  variables {
    name_suffix = "hashitalks"
  }

  assert {
    condition     = startswith(azurerm_resource_group.this.name, "rg-")
    error_message = "Name prefix is not set correctly"
  }
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