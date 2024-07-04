output "vault_instance_id" {
  value = aws_instance.vault.id
}

output "vault_instance_public_ip" {
  value = aws_instance.vault.public_ip
}

output "vault_instance_public_dns" {
  value = aws_instance.vault.public_dns
}
