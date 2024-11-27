# Fetch the latest Amazon Linux 2 AMI
data "aws_ami" "amazonami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Security group for SSH and web access
resource "aws_security_group" "vpc-ssh" {
  name_prefix = "ssh-access-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # always try to use my ip or secure subnet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]# always try to use my ip or secure subnet
  }

  tags = {
    Name = "SSH-SecurityGroup"
  }
}

resource "aws_security_group" "vpc-web" {
  name_prefix = "web-access-"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-SecurityGroup"
  }
}

# EC2 instance 1
resource "aws_instance" "ec2-1" {
  ami           = var.ami_id != "" ? var.ami_id : data.aws_ami.amazonami.id
  instance_type = lookup(var.instance_type, terraform.workspace)
  user_data     = templatefile("user_data.tmpl", { package_name = var.package_name })
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.vpc-ssh.id,
    aws_security_group.vpc-web.id
  ]
  count = var.aws_instance_count

  tags = {
    Name = "Web-Server-1-${terraform.workspace}"
  }
}

# EC2 instance 2
resource "aws_instance" "ec2-2" {
  ami           = var.ami_id != "" ? var.ami_id : data.aws_ami.amazonami.id
  instance_type = lookup(var.instance_type, terraform.workspace)
  user_data     = templatefile("user_data.tmpl", { package_name = var.package_name })
  key_name      = var.key_name
  vpc_security_group_ids = [
    aws_security_group.vpc-ssh.id,
    aws_security_group.vpc-web.id
  ]
  count = var.aws_instance_count

  tags = {
    Name = "Web-Server-2-${terraform.workspace}"
  }
}

# Outputs for instance public IPs
output "ec2_instance_1_public_ips" {
  value       = [for instance in aws_instance.ec2-1 : instance.public_ip]
  description = "Public IPs for EC2 Instance 1"
}

output "ec2_instance_2_public_ips" {
  value       = [for instance in aws_instance.ec2-2 : instance.public_ip]
  description = "Public IPs for EC2 Instance 2"
}
