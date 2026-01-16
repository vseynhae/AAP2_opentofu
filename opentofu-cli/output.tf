output "public_ip_address" {
  value = azurerm_public_ip.main.ip_address
}

output "tls_private_key" {
  value     = tls_private_key.example_ssh.private_key_pem
  sensitive = true
}

output "ssh_command" {
  value = "ssh -i private_key.pem ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
}
