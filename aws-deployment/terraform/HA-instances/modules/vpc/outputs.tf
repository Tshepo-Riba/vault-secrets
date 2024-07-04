output "vault_vpc_id" {
  value = aws_vpc.vault_vpc.id
}

output "vault_subnet_ids" {
  value = aws_subnet.vault_subnets[*].id
}

output "vault_security_group_id" {
  value = aws_security_group.vault_security_group.id
}
