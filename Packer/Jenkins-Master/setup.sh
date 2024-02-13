#!/bin/bash

echo "Installing Amazon Linux extras"
amazon-linux-extras install epel -y

echo "Installing parallel"
sudo yum install parallel -y

echo "removing java from server"
sudo yum remove -y java

echo "updating yum"
sudo yum update –y

# echo "installing java 1.8.0-openjdk"
# yum install -y java-1.8.0-openjdk

echo "downloading jenkins repo"
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo

echo "importing jenkins key"
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

echo "yum upgrade"
sudo yum upgrade

echo "installing java for amazon linux"
sudo dnf install java-17-amazon-corretto -y

echo "installing jenkins using yum"
yum install jenkins -y

echo "configure jenkins to start automaticlly on boot"
sudo systemctl enable jenkins

echo "configure jenkins before starting"

echo "Install git"
sudo yum install -y git

echo "Setup SSH key"
sudo mkdir /var/lib/jenkins/.ssh
sudo touch /var/lib/jenkins/.ssh/known_hosts
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh
sudo chmod 700 /var/lib/jenkins/.ssh
sudo mv /tmp/id_rsa /var/lib/jenkins/.ssh/id_rsa
sudo chmod 600 /var/lib/jenkins/.ssh/id_rsa
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh/id_rsa

echo "Configure Jenkins with groovy scripts"
sudo mkdir -p /var/lib/jenkins/init.groovy.d
sudo mv /tmp/scripts/*.groovy /var/lib/jenkins/init.groovy.d/
sudo chown -R jenkins:jenkins /var/lib/jenkins/init.groovy.d

echo "Configure Jenkins service using sysconfig"
sudo mv /tmp/config/jenkins /etc/sysconfig/jenkins

echo "set chmod +x /tmp/config/install-plugins.sh"
sudo chmod +x /tmp/config/install-plugins.sh

echo "Change ownership of jenkins home directory"
sudo mkdir -p /var/lib/jenkins/plugins/

#sudo jenkins-plugin-cli --plugin-file /tmp/config/plugins.txt
# cp /tmp/config/jenkins-plugin-cli.sh /bin/jenkins-plugin-cli

echo "Run my_plugins_download.sh"
sudo bash /tmp/config/my_plugins_download.sh

echo "Change ownership of jenkins home directory"
sudo chown -R jenkins:jenkins /var/lib/jenkins/plugins

echo "Show all files in plugins directory"
sudo ls -la /var/lib/jenkins/plugins/

# exit -1

echo "starting jenkins service"
sudo systemctl start jenkins

echo "checking jenkins status"
sudo systemctl status jenkins

echo "sleep for 30 seconds"
sudo sleep 30