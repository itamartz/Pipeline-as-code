terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
      #version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Get My Public IP
data "http" "my_public_ip" {
  url = "https://ipinfo.io/json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  public_ip = jsondecode(data.http.my_public_ip.response_body).ip
}

resource "aws_security_group" "jenkins_master_host" {
  name        = "sg_jenkins_master_host"
  description = "Allow SSH from anywhere"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.public_ip}/32"] #["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["${local.public_ip}/32"] #["0.0.0.0/0"]
  }

  tags = {
    Name   = "bastion_sg_jenkins_master_host"
    Author = var.author
  }
}

resource "aws_instance" "test_jenkins_master" {
  ami                         = var.packer_ami_id
  instance_type               = "t2.large"
  key_name                    = "us-west-2-putty"
  vpc_security_group_ids      = [aws_security_group.jenkins_master_host.id]
  associate_public_ip_address = true

  tags = {
    Name   = "test_jenkins_master"
    Author = var.author
  }
}
