variable "packer_ami_id" {
  type        = string
  description = "Packer ID For Jenkins Master AMI"
  default     = "ami-ami-0ddda59d395c08587"
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
