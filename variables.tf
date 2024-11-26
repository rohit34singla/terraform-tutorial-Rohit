variable "region" {
  description = "The AWS region to deploy resources"
  default     = "ca-central-1" # Update as needed
}

variable "ami_id" {
  description = "Amazon Machine Image ID for the EC2 instance"
  default     = "ami-0bcda2433f3dabc41" # Replace with a valid AMI ID for your region
}

variable "instance_type" {
  description = "The type of instance to launch"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "docker" # Replace with your key pair name
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed for SSH access"
  default     = "0.0.0.0/0" # Replace with your IP, e.g., "203.0.113.0/32"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  default     = 2
}

variable "enable_instance" {
  description = "Boolean to enable instance creation"
  default     = true
}