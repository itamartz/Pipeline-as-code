#!/bin/bash

echo "updating yum"
sudo yum update –y

echo "yum upgrade"
sudo yum upgrade

echo "installing java for amazon linux"
sudo dnf install java-17-amazon-corretto -y

echo "Install Docker engine"
sudo yum install docker -y

echo "set usermod -aG docker ec2-user"
usermod -aG docker ec2-user

echo "configure docker to start automaticlly on boot"
sudo systemctl enable docker

echo "Install git"
sudo yum install -y git