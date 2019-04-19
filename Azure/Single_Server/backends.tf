 terraform {
    backend "azurerm" {
        storage_account_name = "terraformstatef7607ae3"
        container_name = "state"
        key = "azsingleserver"
    }
}