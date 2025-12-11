terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.90.0"
    }
  }
}


provider "azurerm" {
    features {}
    subscription_id = "9c249184-a2ca-4b12-89e2-2c4e7b863ab7"
}