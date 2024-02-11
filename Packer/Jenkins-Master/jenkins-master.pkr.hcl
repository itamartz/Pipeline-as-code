packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ssh_key" {
  sensitive = false
  type      = string
  default   = "C:/Users/itamartz/Desktop/us-west-2-putty/id_dsa"
}

source "amazon-ebs" "jenkins-master" {
  ami_name      = "Jenkins-Master-2.426.3"
  instance_type = "t2.micro"
  region        = "us-west-2"
  ssh_username  = "ec2-user"
  source_ami    = "ami-0ecb0bb5d6b19457a"

  tags = {
    "OS"   = "Amazon Linux 2"
    "name" = "jenkins-master"
  }

}

build {
  name = "Build Jenkins Master AMI"
  sources = [
    "source.amazon-ebs.jenkins-master"
  ]

  provisioner "file" {
    source      = "./scripts"
    destination = "/tmp/"
  }

  provisioner "file" {
    source      = "./config"
    destination = "/tmp/"
  }

  provisioner "file" {
    source      = "c:\\Users\\itamartz\\Desktop\\us-west-2-putty\\id_dsa"
    destination = "/tmp/id_rsa"
  }

  provisioner "shell" {
    script          = "./setup.sh"
    execute_command = "sudo -E -S sh '{{ .Path }}'"
  }
}
