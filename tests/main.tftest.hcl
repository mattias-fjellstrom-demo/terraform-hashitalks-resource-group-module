// -----------------------------------------------------------------------------
// CONFIGURE PROVIDERS
// -----------------------------------------------------------------------------
provider "azurerm" {
  features {}
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
