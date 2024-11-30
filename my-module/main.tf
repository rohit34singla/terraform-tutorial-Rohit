resource "aws_instance" "example" {
  ami                    = var.ami
  instance_type          = var.instance_type
  count                  = var.instance_count
  key_name               = var.key_name  # Associate the existing key pair
  security_groups        = [var.security_group]  # Use the existing security group

  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
  }
}
