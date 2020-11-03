provider "aws" {
	region = "us-east-1"
	access_key = ""
	secret_key = ""
}

resource "aws_instance" "web_server" {
	ami = "ami-0817d428a6fb68645"
	instance_type = "t2.micro"
	tags = {
		Name = "Terraform Cloud Instance"
	}
}
