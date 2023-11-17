variables {
  name_suffix = "test"
  location = "swedencentral"
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