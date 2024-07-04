resource "aws_instance" "vault_server" {
  count         = var.vault_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = var.security_group_ids

  // Optionally, other instance configuration settings like key_name, tags, etc.

  // provisioner block to install and configure Vault can be used
  // or you can use user data to bootstrap Vault
}

  iam_instance_profile {
    name = aws_iam_role.vault_ec2_role.name
  }

// Define the Vault backend based on the chosen type
locals {
  vault_backend_module = {
    consul    = "./modules/consul"
    dynamodb  = "./modules/dynamodb"
    // Add more backend modules as needed
  }
}

module "vault_backend" {
  source = local.vault_backend_module[var.vault_backend]

  // Pass backend specific configuration
  backend_config = var.vault_backend_config
}
