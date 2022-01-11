resource "aws_instance" {
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
