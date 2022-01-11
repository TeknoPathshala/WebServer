output "public_ip" {
    value = [ "${aws_instance.devopsroles-lab01.*.public_ip}"]
}
