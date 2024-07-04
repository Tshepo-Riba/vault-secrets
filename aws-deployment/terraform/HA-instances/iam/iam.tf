resource "aws_iam_policy" "dynamodb_policy" {
  name        = "VaultDynamoDBPolicy"
  description = "IAM policy for Vault EC2 instances to access DynamoDB"
  policy      = file("dynamodb_policy.json")
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

resource "aws_iam_role_policy_attachment" "dynamodb_attachment" {
  role       = aws_iam_role.vault_ec2_role.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}
