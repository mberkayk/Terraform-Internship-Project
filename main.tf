variable "access-key" {}
variable "secret-key"{}

provider "aws" {
	region = "us-east-1"
	access_key = var.access-key
	secret_key = var.secret-key
}

resource "aws_instance" "cloud_server" {
	ami = "ami-0817d428a6fb68645"
	instance_type = "t2.micro"
	tags = {
		Name = "Terraform Cloud Instance"
	}
}
