output "IP" {
  value = "${digitalocean_droplet.cobaltstrike.ipv4_address}"
}