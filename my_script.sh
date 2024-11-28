#!/bin/bash
echo "Hello from Terraform Provisioner!" > /home/ubuntu/provisioner_output.txt
sudo apt-get update -y
sudo apt-get install -y nginx
