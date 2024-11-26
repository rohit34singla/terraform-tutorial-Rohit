
resource "aws_security_group" "my_security_group" {
  for_each = { # Create multiple security groups based on this map
    "ssh"  = { from_port = 22, to_port = 22, protocol = "tcp", cidr = var.ssh_allowed_cidr }
    "http" = { from_port = 80, to_port = 80, protocol = "tcp", cidr = "0.0.0.0/0" }
  }

  name_prefix = "allow_access_${each.key}_"

  ingress {
    from_port   = each.value.from_port
    to_port     = each.value.to_port
    protocol    = each.value.protocol
    cidr_blocks = [each.value.cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "MySecurityGroup-${each.key}"
  }
}

resource "aws_instance" "my_ec2_instance" {
  count = var.enable_instance ? var.instance_count : 0
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  provider      = aws

  # Attach security groups dynamically
  vpc_security_group_ids = values(aws_security_group.my_security_group)[*].id

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

  depends_on = [aws_security_group.my_security_group]

  tags = {
    Name = "MyEC2Instance-${count.index}"
  }
}

# Output EC2 Public IPs
output "ec2_public_ips" {
  value       = [for instance in aws_instance.my_ec2_instance : instance.public_ip]
  description = "Public IPs of all created EC2 instances"
}
