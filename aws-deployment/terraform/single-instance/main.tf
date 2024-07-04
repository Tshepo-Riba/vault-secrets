provider "aws" {
  region = var.region
}

resource "aws_security_group" "vault_sg" {
  name_prefix = "vault-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vault-security-group"
  }
}

resource "aws_iam_role" "vault_role" {
  name = "vault-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "vault_policy" {
  name   = "vault-policy"
  role   = aws_iam_role.vault_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyWithoutPlaintext",
          "kms:ReEncrypt*",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_instance" "vault" {
  ami           = var.vault_ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  security_groups = [aws_security_group.vault_sg.name]

  iam_instance_profile = aws_iam_instance_profile.vault_instance_profile.id

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y vault
              cat <<EOT >> /etc/vault/config.hcl
              storage "file" {
                path = "/mnt/vault/data"
              }

              listener "tcp" {
                address     = "0.0.0.0:8200"
                tls_disable = 1
              }

              ui = true
              EOT
              sudo systemctl enable vault
              sudo systemctl start vault
              EOF

  tags = {
    Name = "VaultServer"
  }
}

resource "aws_iam_instance_profile" "vault_instance_profile" {
  name = "vault-instance-profile"
  role = aws_iam_role.vault_role.name
}
