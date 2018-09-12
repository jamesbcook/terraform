variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_key_name" {}

variable "aws_ssh_identity" {}


# Configure the AWS Provider
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-2"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "docker" {
  ami           = "ami-0552e3455b9bc8d50"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  security_groups = ["allow_all"]

  connection {
    type = "ssh"
    user = "ubuntu"
    timeout = "2m"
    agent_identity = "${var.aws_ssh_identity}"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable\"",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce"
    ]
  }
}