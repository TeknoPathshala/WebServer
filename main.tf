resource "aws" {
 count = 3
 ami = var.ami
 instance_type = var.instance_type
 vpc_security_group_ids = ["${aws_security_group.webserver_security_group.id}"]
 tags = {
	 Name = "DevopsRoles-${count.index}"
 }
 key_name = "terra"
 user_data = <<EOF
#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sudo su -c "/bin/echo 'My Site: DevopsRoles.com' >/usr/share/nginx/html/index.html"
instance_ip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
sudo su -c "echo $instance_ip >>/usr/share/nginx/html/index.html"
sudo systemctl start nginx
sudo systemctl enable  nginx
EOF
}

provider "aws" {
  region     = "us-east-2"
  access_key = "AKIA4Q4JUKWLDUPP6DFJ"
  secret_key = "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"
}

#Create security group with firewall rules
resource "aws_security_group" "my_security_group" {
  name        = var.security_group
  description = "security group for Ec2 instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}

# Create AWS ec2 instance
resource "aws_instance" "myFirstInstance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = var.tag_name
  }
}
