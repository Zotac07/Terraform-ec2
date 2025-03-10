variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "email" {
  description = "Email address to send the SSH key pair"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "instance_type for the EC2 instance"
  type        = string
}