provider "aws" {
  region = var.region
}

variable "region" {
  description = "AWS region for the resources"
  type        = string
  default     = "ca-central-1"
}