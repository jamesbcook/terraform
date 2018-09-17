output "IP" {
  value = "${digitalocean_droplet.cobaltstrike.ipv4_address}"
}

output "Notice" {
  value = "Perform the following\nPoint an A record to ${digitalocean_droplet.cobaltstrike.ipv4_address}\nssh root@${digitalocean_droplet.cobaltstrike.ipv4_address}\n/opt/puppetlabs/bin/puppet apply --modulepath=/root/manifests/modules/ /root/manifests/default.pp"
}