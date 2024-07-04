# Create VPC
resource "aws_vpc" "vault_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "Vault-VPC"
  }
}

# Create subnets in each availability zone
resource "aws_subnet" "vault_subnets" {
  count             = length(var.subnet_cidr_blocks)
  vpc_id            = aws_vpc.vault_vpc.id
  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "Vault-Subnet-${count.index + 1}"
  }
}

# Create a security group for Vault instances
resource "aws_security_group" "vault_security_group" {
  name        = "vault-security-group"
  description = var.vault_security_group_description
  vpc_id      = aws_vpc.vault_vpc.id

  // Example rule: Allow Vault server access within the security group
  ingress {
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }

  // Add more ingress/egress rules as needed for your Vault setup
}
