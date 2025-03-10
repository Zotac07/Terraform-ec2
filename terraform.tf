terraform {
  cloud {
    organization = "vaishnav-test"

    workspaces {
      name = "Terraform-ec2"
    }
  }
}   