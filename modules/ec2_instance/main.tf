resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.instance_name}-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.generated_key.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd mailx
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello, World!" > /var/www/html/index.html
              EOF

  tags = {
    Name = var.instance_name
  }
}

resource "local_file" "ssh_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${var.instance_name}-key.pem"
}

resource "aws_ses_email_identity" "email" {
  email = var.email
}

resource "null_resource" "send_email" {
  provisioner "local-exec" {
    command = <<EOT
      echo "SSH Key for ${var.instance_name}:" | mail -s "EC2 SSH Key" -A ${local_file.ssh_key.filename} ${var.email}
    EOT
  }

  depends_on = [local_file.ssh_key, aws_ses_email_identity.email]
}

output "instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "ssh_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}