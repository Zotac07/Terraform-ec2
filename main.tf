terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "ec2_instance" {
  source = "./modules/ec2_instance"

  instance_name = var.instance_name
  email         = var.email
  ami_id        = var.ami_id
  instance_type = var.instance_type
}