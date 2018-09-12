output "IP" {
  value = "${digitalocean_droplet.docker.ipv4_address}"
}