data "aws_instance" "instance_info" {
  filter {
    name = "tag:Name"
    values = [format("terraform-ec2-%s", terraform.workspace)]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  } 

  depends_on = [ aws_instance.terra_ec2 ]
}

resource "aws_instance" "terra_ec2" {
  ami                         = "ami-0f5ee92e2d63afc18"
  associate_public_ip_address = true
  availability_zone           = format("%sa", var.region)
  instance_type               = "t2.micro"
  key_name                    = "Local"
  vpc_security_group_ids      = [aws_security_group.terraform_sg.id]
  subnet_id                   = module.less_vpc.public_subnet_id[0]
  tenancy                     = "default"
  monitoring                  = false

  tags = {
    Name = format("terraform-ec2-%s", terraform.workspace)
    env  = format("%s", terraform.workspace)
  }

  depends_on = [ module.less_vpc ]
}

resource "null_resource" "cluster" {

  triggers = {
    runnig_number = var.running_number
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host = aws_instance.terra_ec2.public_ip
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo apt-get update",
      "curl -fsSL https://get.docker.com -o install-docker.sh",
      "sh install-docker.sh --dry-run",
      "sudo sh install-docker.sh",
      "sudo usermod -aG docker $USER",
      "sudo chmod 666 /var/run/docker.sock",
     ]
  }

}
