output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2_instance.instance_public_ip
}

output "ssh_key" {
  description = "SSH private key for the EC2 instance"
  value       = module.ec2_instance.ssh_key
  sensitive   = true
}