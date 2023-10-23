output "instance_public_ip" {
  value = data.aws_instance.instance_info.public_ip
}