output "IP" {
  value = "${aws_instance.cobaltstrike.public_ip}"
}