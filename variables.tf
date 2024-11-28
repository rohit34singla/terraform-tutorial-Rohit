variable "aws_region" {
  default = "ca-central-1"
}

variable "ami_id" {
  default = "ami-0eb9fdcf0d07bd5ef"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Name of the existing SSH key pair in AWS"
  default     = "Terraform_infra"  # The name of your AWS EC2 key pair
}

variable "pem_file_path" {
  description = "Path to your PEM file for SSH"
  default     = "C:/Users/rohit/OneDrive/Desktop/Terraform/Terraform_infra.pem"
}