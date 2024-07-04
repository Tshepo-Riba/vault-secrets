ami_id              = "your_ami_id"
subnet_id           = "subnet-xxxxxxxx"
security_group_ids  = ["sg-xxxxxxxx"]
vault_backend       = "consul"
vault_backend_config = {
  consul_address = "consul_server_private_ip:8500"
}
