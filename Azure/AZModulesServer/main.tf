
data "azurerm_virtual_network" "enetwork" {
  name = "vnet-tf-1"
  resource_group_name = "Terraform-NW"
}

data "azurerm_subnet" "esubnet" {
  name                 = "WebServers"
  virtual_network_name = "${data.azurerm_virtual_network.enetwork.name}"
  resource_group_name  = "${data.azurerm_virtual_network.enetwork.resource_group_name}"
}

module "compute" {
  source  = "Azure/compute/azurerm"
  version = "1.2.1"

  # insert the 2 required variables here
  location = "eastus"
  vnet_subnet_id      = "${data.azurerm_subnet.esubnet.vnet_subnet_id}"
}
module "windowsservers" {
    source              = "Azure/compute/azurerm"
    location            = "eastus"
    vm_hostname         = "mysimplevm" // line can be removed if only one VM module per resource group
    admin_password      = "ComplxP@ssw0rd!"
    vm_os_simple        = "WindowsServer"
    is_windows_image    = "true"
    public_ip_dns       = ["somesimpleserver"] // change to a unique name per datacenter region
    vnet_subnet_id      = "${data.azurerm_subnet.esubnet.vnet_subnet_id}"
  }

