
data "aws_ami" "bastion" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_key_pair" "management" {
  key_name   = "management"
  public_key = file(var.public_key)
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

resource "aws_security_group" "bastion_host" {
  name        = "bastion_sg_${var.vpc_name}"
  description = "Allow SSH from anywhere"
  vpc_id      = aws_vpc.management.id

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

  tags = {
    Name   = "bastion_sg_${var.vpc_name}"
    Author = var.author
  }
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.bastion.id
  instance_type               = var.bastion_instance_type
  key_name                    = aws_key_pair.management.id
  vpc_security_group_ids      = [aws_security_group.bastion_host.id]
  subnet_id                   = element(aws_subnet.public_subnets, 0).id
  associate_public_ip_address = true

  tags = {
    Name   = "bastion"
    Author = var.author
  }
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}
output "bastion_public_dns" {
  value = aws_instance.bastion.public_dns
}
