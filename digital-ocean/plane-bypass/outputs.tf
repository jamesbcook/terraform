output "IP" {
  value = "${digitalocean_droplet.plane-bypass.ipv4_address}"
}