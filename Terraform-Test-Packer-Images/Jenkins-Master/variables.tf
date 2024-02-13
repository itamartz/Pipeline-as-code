variable "packer_ami_id" {
  type        = string
  description = "Packer ID For Jenkins Master AMI"
  default     = "ami-0f26c83d2cbdc5077"
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
