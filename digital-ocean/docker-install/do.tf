variable "do_token" {}
variable "do_ssh_fingerprint" {}
variable "do_ssh_identity" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "docker" {
  image  = "ubuntu-14-04-x64"
  name   = "docker-1"
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
        "apt-get update",
        "apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
        "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -",
        "add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu trusty stable\"",
        "apt-get update",
        "apt-get install -y docker-ce"
      ]
  }
}

