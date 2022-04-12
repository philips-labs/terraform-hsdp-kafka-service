terraform {
  required_version = ">= 0.15.1"

  required_providers {
    hsdp = {
      source  = "philips-software/hsdp"
      version = ">=0.31.0"
    }

    cloudfoundry = {
      source  = "cloudfoundry-community/cloudfoundry"
      version = ">= 0.15.3"
    }
  }
}

// Best practice is to have versions.tf and not terraform.tf