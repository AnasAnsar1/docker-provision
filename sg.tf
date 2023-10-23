resource "aws_security_group" "terraform_sg" {

  name   = "terra-ec2-sg"
  vpc_id = module.less_vpc.vpc_id

  ingress {
    protocol         = "tcp"
    from_port        = 22
    to_port          = 22
    cidr_blocks      = local.ALL
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.ALL
  }

  ingress {
    protocol         = "tcp"
    from_port        = 80
    to_port          = 80
    cidr_blocks      = local.ALL
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.ALL
  }

  ingress {
    protocol         = "tcp"
    from_port        = 0
    to_port          = 65535
    cidr_blocks      = local.ALL
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.ALL
  }


  tags = {
    Name = var.sg_name
  }

  depends_on = [module.less_vpc]

}
