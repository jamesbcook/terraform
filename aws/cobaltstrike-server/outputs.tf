output "IP" {
  value = "${aws_instance.cobaltstrike.public_ip}"
}

output "Notice" {
  value = "Perform the following\nPoint an A record to ${aws_instance.cobaltstrike.public_ip}\nssh ubuntu@${aws_instance.cobaltstrike.public_ip}\nsudo /opt/puppetlabs/bin/puppet apply --modulepath=/home/ubuntu/manifests/modules/ /home/ubuntu/manifests/default.pp"
}