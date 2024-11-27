variable "ami_id" {
  description = "Custom AMI ID to use for the EC2 instance. Leave empty to use the default Amazon Linux 2 AMI."
  default     = ""
}

variable "instance_type" {
  description = "Mapping of instance types per environment"
  default     = {
    default = "t2.micro"
    dev     = "t2.micro"
    prod    = "t2.medium"
  }
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "docker"
}

variable "aws_instance_count" {
  description = "Number of EC2 instances to create"
  default     = 1
}

variable "package_name" {
  description = "Package name to install in user data script"
  default     = "nginx"
}

variable "region" {
  description = "Canada region"
  default = "ca-central-1"
  
}