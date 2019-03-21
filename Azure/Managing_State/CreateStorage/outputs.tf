output "storage_name" {
  value = "${azurerm_storage_account.storageacct.id}"
}

output "storage_container_name" {
  value = "${azurerm_storage_container.container.id}"
}

output "primary_key" {
  value = "${azurerm_storage_account.storageacct.primary_access_key}"
}

