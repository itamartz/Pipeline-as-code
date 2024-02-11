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
  default   = "C:\\Users\\itamartz\\Desktop\\us-west-2.pem"
}

# "ami-0ecb0bb5d6b19457a"
source "amazon-ebs" "jenkins-worker" {
  ami_name        = "jenkins-worker"
  ami_description = "Jenkins Worker's AMI"
  instance_type   = "t2.micro"
  region          = "us-west-2"
  ssh_username    = "ec2-user"
  source_ami      = "ami-0d442a425e2e0a743"
  run_tags = {
    Name = "packer-jenkins-worker"
  }

  tags = {
    "OS"   = "Amazon Linux AMI"
    "name" = "jenkins-worker"
  }
}

build {
  name = "Build Jenkins Worker AMI"
  sources = [
    "source.amazon-ebs.jenkins-worker"
  ]


  provisioner "shell" {
    script          = "./setup.sh"
    execute_command = "sudo -E -S sh '{{ .Path }}'"
  }
}