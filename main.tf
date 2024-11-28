resource "aws_instance" "EC2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name    # Reference the existing key pair name

  # Security group to allow SSH
  vpc_security_group_ids = [aws_security_group.ssh.id]

  provisioner "file" {
    source      = "my_script.sh"         # File to copy
    destination = "/home/ubuntu/my_script.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"            # Adjust based on your AMI
      private_key = file(var.pem_file_path) # Use the provided PEM file
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/my_script.sh",
      "sudo /home/ubuntu/my_script.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.pem_file_path)
      host        = self.public_ip
    }
  }

  tags = {
    Name = "Provisioner-Example"
  }
}

resource "aws_security_group" "ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow from anywhere; adjust for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Output the public IP of the EC2 instance
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.EC2.public_ip
}