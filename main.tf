provider "aws" {
	region = "us-east-1"
	access_key = var.root-access-key
	secret_key = var.root-secret-key
}

provider "aws" {
	alias = "ec2"
	region = "us-east-1"
	access_key = var.ec2-access-key
	secret_key = var.ec2-secret-key
}

provider "aws" {
	alias = "s3"
	region = "us-east-1"
	access_key = var.s3-access-key
	secret_key = var.s3-secret-key
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
}
*/

resource "aws_s3_bucket" "mybucket" {
	provider = aws.s3
	bucket = "mberkayk.created-with-tf"
}

