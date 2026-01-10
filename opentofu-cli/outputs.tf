output "public_ip" {
  value = aws_instance.centos.public_ip
  description = "The public IP address of the EC2 instance"
}

