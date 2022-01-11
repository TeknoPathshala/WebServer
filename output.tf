output "public_ip" {
    value = [ "${aws_instance.devopsroles-lab01.*.public_ip}"]
}

Create new file variables.tf with the content as below

variable "region" {
	description = " Define the AWS region "
	default = "us-west-2"
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
variable "my_public_ip" {
	description = "My laptop public IP ..." 
        default = "116.110.26.150/32"
}
variable "ami" {
description = "amazon machine image"
default = "ami-0c2d06d50ce30b442"
}

variable "azs" {
default = [ "us-east-2a", "us-east-2b", "us-east-2c"]
}
