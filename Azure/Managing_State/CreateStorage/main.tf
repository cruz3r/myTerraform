resource "azurerm_resource_group" "rg" {
        name = "${var.name}-RG"
        location = "eastus"
    tags {
        environment = "Terraform Demo"
    }
}

resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = "${azurerm_resource_group.rg.name}"
    }

    byte_length = 4
}
resource "azurerm_storage_account" "storageacct" {
    name                = "${lower(var.name)}state${lower(random_id.randomId.hex)}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    location            = "eastus"
    account_replication_type = "LRS"
    account_tier = "Standard"

    tags {
        environment = "Terraform Demo"
    }
}

resource "azurerm_storage_container" "container" {
  name                  = "state"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  storage_account_name  = "${azurerm_storage_account.storageacct.name}"
  container_access_type = "private"
}
