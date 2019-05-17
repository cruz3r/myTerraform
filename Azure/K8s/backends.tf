 terraform {
    backend "azurerm" {
        storage_account_name = "terraformstatef739d86a"
        container_name = "state"
        key = "k8s"
    }
}