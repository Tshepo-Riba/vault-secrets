resource "aws_iam_policy" "consul_policy" {
  name        = "VaultConsulPolicy"
  description = "IAM policy for Vault EC2 instances to access Consul"
  policy      = file("consul_policy.json")
}

resource "aws_iam_role" "vault_ec2_role" {
  name               = "VaultEC2Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "consul_attachment" {
  role       = aws_iam_role.vault_ec2_role.name
  policy_arn = aws_iam_policy.consul_policy.arn
}
