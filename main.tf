# Security Group to allow SSH and HTTP access
resource "aws_security_group" "my_security_group" {
  name_prefix = "allow_access_"

  # Ingress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr] # Restrict SSH access
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open HTTP (80) to the public
  }

  # Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "my_ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  # Associate security group
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  # User data to configure Docker and NGINX
  user_data = <<EOF
#!/bin/bash
set -e  # Exit on any error

# Update the system and install Docker
yum update -y
yum install -y docker

# Start Docker and enable it to start on boot
systemctl start docker
systemctl enable docker

# Pull and run the NGINX container
docker pull nginx:alpine
docker run -d --name my-first-container -p 80:80 nginx:alpine
EOF

  # Tags
  tags = {
    Name = "MyEC2Instance-Docker"
  }
}

# Output EC2 Public IP
output "ec2_public_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}
