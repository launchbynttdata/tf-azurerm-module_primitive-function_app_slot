terraform {
  required_version = "~> 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.30"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }

  }
}
