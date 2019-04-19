data "azurerm_virtual_network" "enetwork" {
  name = "vnet-tf-1"
  resource_group_name = "Terraform-NW"
}

data "azurerm_subnet" "esubnet" {
  name                 = "WebServers"
  virtual_network_name = "${data.azurerm_virtual_network.enetwork.name}"
  resource_group_name  = "${data.azurerm_virtual_network.enetwork.resource_group_name}"
}

resource "azurerm_resource_group" "rg" {
        name = "${var.name}-RG-${var.count_id}"
        location = "eastus"
    tags {
        environment = "Terraform Demo"
    }
}

resource "azurerm_automation_account" "aa" {
  name                = "${var.name}-AA-${var.count_id}"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  sku {
    name = "Basic"
  }
}

#resource "azurerm_virtual_network" "network" {
#    name                = "${var.name}-Vnet-${var.count_id}"
#    address_space       = ["192.168.1.0/24"]
#    location            = "eastus"
#    resource_group_name = "${azurerm_resource_group.rg.name}"
#
#    tags {
#        environment = "Terraform Demo"
#    }
#}

#resource "azurerm_subnet" "subnet" {
#    name                 = "${var.name}-subnet-${var.count_id}"
#    resource_group_name  = "${azurerm_resource_group.rg.name}"
#    virtual_network_name = "${azurerm_virtual_network.network.name}"
#    address_prefix       = "192.168.1.0/28"
#}

resource "azurerm_public_ip" "publicip" {
    name                         = "${var.name}-publicIP-${var.count_id}"
    location                     = "eastus"
    resource_group_name          = "${azurerm_resource_group.rg.name}"
    allocation_method            = "Dynamic"

    tags {
        environment = "Terraform Demo"
    }
}
resource "azurerm_network_security_group" "nsg" {
    name                = "${var.name}-NSG-${var.count_id}"
    location            = "eastus"
    resource_group_name = "${azurerm_resource_group.rg.name}"
# Not needed now that going through VPN
#    security_rule {
#        name                       = "SSH"
#        priority                   = 1001
#        direction                  = "Inbound"
#        access                     = "Allow"
#        protocol                   = "Tcp"
#        source_port_range          = "*"
#        destination_port_range     = "22"
#        source_address_prefix      = "*"
#        destination_address_prefix = "*"
#    },
    security_rule {
        name                       = "HTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags {
        environment = "Terraform Demo"
    }
}

resource "azurerm_network_interface" "nic" {
    name                = "${var.name}-NIC-${var.count_id}"
    location            = "eastus"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    network_security_group_id = "${azurerm_network_security_group.nsg.id}"

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = "${data.azurerm_subnet.esubnet.id}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "${azurerm_public_ip.publicip.id}"
    }

    tags {
        environment = "Terraform Demo"
    }
}

resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = "${azurerm_resource_group.rg.name}"
    }

    byte_length = 8
}

resource "azurerm_storage_account" "storageacct" {
    name                = "diag${random_id.randomId.hex}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    location            = "eastus"
    account_replication_type = "LRS"
    account_tier = "Standard"

    tags {
        environment = "Terraform Demo"
    }
}

resource "azurerm_virtual_machine" "vm" {
    name                  = "${var.name}-VM-${var.count_id}"
    location              = "eastus"
    resource_group_name   = "${azurerm_resource_group.rg.name}"
    network_interface_ids = ["${azurerm_network_interface.nic.id}"]
    vm_size               = "Standard_DS1_v2"

    storage_os_disk {
        name              = "${var.name}-OSDisk-${var.count_id}"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "${var.name}-VM-${var.count_id}"
        admin_username = "${var.user_name}"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/${var.user_name}/.ssh/authorized_keys"
            key_data = "${var.ssh_pub_key}"
        }
    }

    boot_diagnostics {
        enabled     = "true"
        storage_uri = "${azurerm_storage_account.storageacct.primary_blob_endpoint}"
    }

    tags {
        environment = "Terraform Demo"
    }
}
resource "azurerm_virtual_machine_extension" "test" {
  name                 = "hostname"
  location             = "eastus"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_machine_name = "${azurerm_virtual_machine.vm.name}"
  publisher            = "Microsoft.OSTCExtensions"
  type                 = "CustomScriptForLinux"
  type_handler_version = "1.2"
  depends_on = ["azurerm_virtual_machine.vm"]

  settings = <<SETTINGS
    {
        "fileUris": ["https://terraformstatef7607ae3.blob.core.windows.net/scripts/web.sh"],
        "commandToExecute": "sh web.sh"

    }
SETTINGS
}