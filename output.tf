output "public_ip" {
    value = [ "${aws_instance.devopsroles-lab01.*.public_ip}"]
}

Create new file variables.tf with the content as below

variable "region" {
	description = " Define the AWS region "
	default = "us-east-2"
}
variable "server_port" {
	description = "http service listen"
	default = "80"
}

variable "ssh_port" {
	description = "ssh to server"
	default = "22"
}
variable "instance_type" { 
	description = "AWS ec2 instance type"
	default="t2.micro"
}
variable "ami" {
description = "amazon machine image"
default = "ami-001089eb624938d9f"
}

variable "azs" {
default = [ "us-east-2a", "us-east-2b", "us-east-2c"]
}
