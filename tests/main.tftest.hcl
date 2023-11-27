variables {
  name_suffix = "test"
  location = "swedencentral"
}

provider "azurerm" {
  features {}
}

run "do_not_allow_rg_prefix" {
  command = plan

  variables {
    name_suffix = "rg-test"
  }

  expect_failures = [
    var.name_suffix
  ]
}

run "do_not_allow_us_location" {
  command = plan

  variables {
    location = "westus"
  }

  expect_failures = [
    var.location
  ]
}

run "do_not_accept_too_long_name" {
  command = plan

  variables {
    name_suffix = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
  }
}

run "verify_output" {
  command = apply

  assert {
    condition     = lookup(output.resource_group, "id", "failed") != "failed"
    error_message = "Output did not have an ID field"
  }

  assert {
    condition     = lookup(output.resource_group, "name", "failed") != "failed"
    error_message = "Output did not have a name field"
  }

  assert {
    condition     = lookup(output.resource_group, "location", "failed") != "failed"
    error_message = "Output did not have a location field"
  }

  assert {
    condition     = lookup(output.resource_group, "tags", "failed") != "failed"
    error_message = "Output did not have a tags field"
  }
}