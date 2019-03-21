output "virtual_machine_id" {
  value = "${azurerm_virtual_machine.vm.id}"
}
output "public_ip_address" {
  value = "${azurerm_public_ip.publicip.ip_address}"
}

output "ssh" {
  value = "ssh ${var.user_name}@${azurerm_public_ip.publicip.ip_address}"
}