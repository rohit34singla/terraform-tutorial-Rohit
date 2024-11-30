module "ec2_instances" {
  source          = "./my-module"
  ami             = "ami-049332278e728bdb7"
  instance_type   = "t2.micro"
  instance_count  = 2
  key_name        = "Terraform_infra"  # Corrected key name
  security_group  = "mysg"
  instance_name   = "MyAppInstance"
  region          = "ca-central-1"
}


output "ec2_ids" {
  value = module.ec2_instances.instance_ids
}

output "ec2_public_ips" {
  value = module.ec2_instances.public_ips
}
