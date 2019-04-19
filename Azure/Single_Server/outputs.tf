output "virtual_machine_id" {
  value = "${azurerm_virtual_machine.vm.id}"
}
output "public_ip_address" {
  value = "http://${azurerm_public_ip.publicip.ip_address}:${var.server_port}"
}

output "ssh_name" {
  value = "ssh -i (path to pem) ${var.user_name}@${azurerm_network_interface.nic.private_ip_address} "
}