output "IP" {
  value = "${aws_instance.docker.public_ip}"
}