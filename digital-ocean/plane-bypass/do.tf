variable "do_token" {}
variable "do_ssh_fingerprint" {}
variable "do_ssh_identity" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "plane-bypass" {
  image  = "ubuntu-14-04-x64"
  name   = "plane-bypass"
  region = "nyc1"
  size   = "512mb"
  ssh_keys = [
    "${var.do_ssh_fingerprint}"
  ]
  connection {
    type = "ssh"
    user = "root"
    timeout = "2m"
    agent_identity = "${var.do_ssh_identity}"
  }

  provisioner "remote-exec" {
      inline = [
        "sed -i 's/Port 22/Port 3128/' /etc/ssh/sshd_config",
        "service ssh restart"
      ]
  }
}

