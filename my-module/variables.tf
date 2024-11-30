variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2
}

variable "key_name" {
  description = "Name of the existing AWS key pair"
  type        = string
}

variable "security_group" {
  description = "Name of the existing security group"
  type        = string
}

variable "instance_name" {
  description = "Base name for the instances"
  type        = string
}
