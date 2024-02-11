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
