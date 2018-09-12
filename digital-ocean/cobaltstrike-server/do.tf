variable "do_token" {}
variable "do_ssh_fingerprint" {}
variable "do_ssh_identity" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "cobaltstrike" {
  image  = "ubuntu-14-04-x64"
  name   = "cobaltstrike-1"
  region = "nyc1"
  size   = "s-1vcpu-2gb"
  ssh_keys = [
    "${var.do_ssh_fingerprint}"
  ]
  connection {
    type = "ssh"
    user = "root"
    timeout = "2m"
    agent_identity = "${var.do_ssh_identity}"
  }

  provisioner "file" {
    source      = "manifests"
    destination = "/root/"
  }

  provisioner "remote-exec" {
      inline = [
        "wget -O /tmp/puppet5-release-trusty.deb https://apt.puppetlabs.com/puppet5-release-trusty.deb",
        "dpkg -i /tmp/puppet5-release-trusty.deb",
        "apt-get update",
        "apt-get install -y apt-transport-https ca-certificates curl default-jre software-properties-common puppet-agent",
        "/opt/puppetlabs/bin/puppet apply --modulepath=/root/manifests/modules/ /root/manifests/default.pp"
      ]
  }
}