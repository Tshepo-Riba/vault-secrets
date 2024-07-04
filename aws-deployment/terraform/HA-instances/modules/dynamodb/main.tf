variable "dynamodb_access_key" {
  description = "AWS access key for DynamoDB backend"
  type        = string
}

variable "dynamodb_secret_key" {
  description = "AWS secret key for DynamoDB backend"
  type        = string
}

variable "dynamodb_region" {
  description = "AWS region for DynamoDB backend"
  type        = string
}

variable "dynamodb_table" {
  description = "DynamoDB table name for Vault backend"
  type        = string
}

resource "vault_backend_aws_dynamodb" "dynamodb_backend" {
  access_key = var.dynamodb_access_key
  secret_key = var.dynamodb_secret_key
  region     = var.dynamodb_region
  table      = var.dynamodb_table
}
