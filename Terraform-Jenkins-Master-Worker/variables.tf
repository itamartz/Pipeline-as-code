// Provided at runtime

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-west-2"
}

# variable "shared_credentials_file" {
#   type        = string
#   description = "AWS credentials file path"
# }

# variable "aws_profile" {
#   type        = string
#   description = "AWS profile"
# }

variable "author" {
  type        = string
  description = "Created by"
  default     = "Itamar Tziger"
}

variable "availability_zones" {
  type        = list(any)
  description = "List of Availability Zones"
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "public_key" {
  type        = string
  description = "SSH public key path"
  default     = "C:\\Users\\itamartz\\Desktop\\us-west-2-putty\\id_rsa.pub"
}

# variable "hosted_zone_id" {
#   type        = string
#   description = "Route53 hosted zone id"
# }

# variable "domain_name" {
#   type        = string
#   description = "Domain name"
# }

variable "ssl_arn" {
  type        = string
  description = "ACM SSL ARN"
  default     = "arn:aws:acm:us-west-2:887234254276:certificate/e77628e7-a155-47e1-a30a-ee8fad9816ef"
}

variable "jenkins_username" {
  type        = string
  description = "Jenkins admin user"
  default     = "admin"
}

variable "jenkins_password" {
  type        = string
  description = "Jenkins admin password"
}

# variable "jenkins_credentials_id" {
#   type        = string
#   description = "Jenkins workers SSH based credentials id"
# }

// Default values

variable "vpc_name" {
  type        = string
  description = "VPC name"
  default     = "management"
}

variable "cidr_block" {
  type        = string
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnets_count" {
  type        = number
  description = "Number of public subnets"
  default     = 2
}

variable "private_subnets_count" {
  type        = number
  description = "Number of private subnets"
  default     = 2
}

variable "bastion_instance_type" {
  type        = string
  description = "Bastion instance type"
  default     = "t2.micro"
}

variable "jenkins_master_instance_type" {
  type        = string
  description = "Jenkins master EC2 instance type"
  default     = "t2.large"
}

variable "jenkins_worker_instance_type" {
  type        = string
  description = "Jenkins worker EC2 instance type"
  default     = "t2.medium"
}
