# AWS Provider Configuration
variable "region" {
  description = "AWS region"
  default     = "ca-central-1"
}

# VPC Configuration
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability Zone for the public subnet"
  default     = "ca-central-1a"
}

# Security Group Configuration
variable "allowed_http_cidr_blocks" {
  description = "Allowed CIDR blocks for HTTP traffic"
  default     = ["0.0.0.0/0"]
}

variable "allowed_ssh_cidr_blocks" {
  description = "Allowed CIDR blocks for SSH traffic"
  default     = ["99.251.169.229/32"]
}

# EC2 Configuration
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0bcda2433f3dabc41"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}

variable "key_name" {
  description = "docker"
}