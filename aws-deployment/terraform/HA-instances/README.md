# Deploying Vault in High-Availability on AWS using Terraform

This repository provides Terraform scripts to deploy HashiCorp Vault in a high-availability (HA) configuration on AWS. Vault will be configured with integrated storage using AWS DynamoDB as the backend.

## Prerequisites

Before you begin, ensure you have the following:

- AWS account with appropriate permissions to create EC2 instances, DynamoDB tables, IAM roles, etc.
- Terraform installed on your local machine. You can download it from [terraform.io](https://www.terraform.io/downloads.html).
- AWS CLI configured locally with credentials that have sufficient permissions for creating resources.

## Configuration Overview

The Terraform configuration in this repository will:

- Deploy multiple Vault server instances across different availability zones (AZs) for high availability.
- Configure Vault to use AWS DynamoDB as the backend storage for data persistence.
- Set up necessary networking (VPC, subnets, security groups) for the Vault instances.
- Configure IAM roles and policies for EC2 instances to access DynamoDB.

## Usage

### 1. Clone the Repository

```bash
git clone <repository_url>
cd <repository_name>
```
2. Initialize Terraform
```bash
terraform init
```
3. Prepare Terraform Variables
Create a terraform.tfvars file and specify values for the required variables:

# terraform.tfvars
```bash
ami_id              = "your_ami_id"
instance_type       = "t2.medium"
subnet_id           = "subnet-xxxxxxxx"
security_group_ids  = ["sg-xxxxxxxx"]
vault_count         = 3
vault_backend       = "dynamodb"
vault_backend_config = {
  access_key = "your_aws_access_key"
  secret_key = "your_aws_secret_key"
  region     = "us-east-1"
  table      = "vault"
}
```
4. Review and Apply Terraform Plan
```bash
terraform plan -var-file="terraform.tfvars"
```
Review the output to ensure Terraform will create/update resources as expected.

5. Apply Terraform Changes
```bash
terraform apply -var-file="terraform.tfvars"
```
Confirm the deployment by typing yes when prompted.

6. Accessing Vault
Once Terraform completes deployment:

Access Vault using its public or private endpoint, depending on your setup.
Initialize and unseal Vault as per your organization's security policies.
7. Cleanup
To destroy all created resources after testing or when no longer needed:

```bash
terraform destroy -var-file="terraform.tfvars"
```
### Contributing
Contributions are welcome! Please fork the repository and submit pull requests to propose improvements or fixes.

### License
This project is licensed under the MIT License.