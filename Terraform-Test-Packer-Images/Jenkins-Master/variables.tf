variable "packer_ami_id" {
  type        = string
  description = "Packer ID For Jenkins Master AMI"
  default     = "ami-0c08f89baa10be745"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-west-2"
}

variable "author" {
  type        = string
  description = "Created by"
  default     = "Itamar Tziger"
}
