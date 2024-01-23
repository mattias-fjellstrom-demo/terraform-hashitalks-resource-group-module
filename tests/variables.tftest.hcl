// -----------------------------------------------------------------------------
// CONFIGURE PROVIDERS
// -----------------------------------------------------------------------------
provider "azurerm" {
  features {}
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
