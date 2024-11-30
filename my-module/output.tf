output "instance_ids" {
  description = "IDs of the created EC2 instances"
  value       = aws_instance.example[*].id
}

output "public_ips" {
  description = "Public IPs of the created EC2 instances"
  value       = aws_instance.example[*].public_ip
}

output "private_ips" {
  description = "Private IPs of the created EC2 instances"
  value       = aws_instance.example[*].private_ip
}
