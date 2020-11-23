provider "vault" {}

resource "vault_aws_secret_backend" "aws"{
	access_key = var.root-access-key
	secret_key = var.root-secret-key
	region = "us-east-1"
	path= "aws"

  default_lease_ttl_seconds = "120"
  max_lease_ttl_seconds     = "240"
}

resource "vault_aws_secret_backend_role" "ec2-role" {
  backend = vault_aws_secret_backend.aws.path
  name    = "dynamic-vault-ec2-role"
  credential_type = "iam_user"

  policy_arns = ["arn:aws:iam::427790202393:policy/ec2-Policy"]
}

resource "vault_aws_secret_backend_role" "s3-role" {
  backend = vault_aws_secret_backend.aws.path
  name    = "dynamic-vault-s3-role"
  credential_type = "iam_user"

  policy_arns = ["arn:aws:iam::427790202393:policy/S3-Policy"]
}

data "vault_aws_access_credentials" "ec2-creds" {
  backend = vault_aws_secret_backend.aws.path
  role    = vault_aws_secret_backend_role.ec2-role.name
}

data "vault_aws_access_credentials" "s3-creds" {
  backend = vault_aws_secret_backend.aws.path
  role    = vault_aws_secret_backend_role.s3-role.name
}

provider "aws" {
	region = "us-east-1"
	access_key = var.root-access-key
	secret_key = var.root-secret-key
}

provider "aws" {
	alias = "ec2"
	region = "us-east-1"
	access_key = data.vault_aws_access_credentials.ec2-creds.access_key
	secret_key = data.vault_aws_access_credentials.ec2-creds.secret_key
}

provider "aws" {
	alias = "s3"
	region = "us-east-1"
	access_key = data.vault_aws_access_credentials.s3-creds.access_key
	secret_key = data.vault_aws_access_credentials.s3-creds.secret_key
}


terraform {
	backend "s3" {
		bucket = "mberkayk.tf-state-bucket"
		key    = "terraform.tfstate"
		region = "us-east-1"
  }
}

/*
resource "aws_instance" "cloud_server" {
	provider = aws.ec2
	ami = "ami-0817d428a6fb68645"
	instance_type = "t2.micro"
	tags = {
		Name = "Terraform Cloud Instance"
	}
}*/


resource "aws_s3_bucket" "mybucket" {
	provider = aws.s3
	bucket = "mberkayk.created-with-tf"
}

