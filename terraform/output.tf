output "vm_password" {
  value = random_password.password.result
  sensitive = true
}

output "vm_publicip" {
  value = azurerm_public_ip.this.ip_address
}