module "less_vpc" {
  source = "git::https://github.com/AnasAnsar1/Vpc_module.git"

  region = "ap-south-1"

  vpc_info = {
    cidr_block         = "10.0.0.0/16"
    tags               = "terraform_vpc"
    instance_tenancy   = "default"
    enable_dns_support = "true"
  }

  Public_Subnet_name    = ["terra_ec2_Public_subnet_1"]

  Private_Subnet_name   = ["terra_ec2_Private_subnet_1"]

  Internet_gateway_name = ["terra_ec2_vpc_igway"]

  Public_rt_name        = "Public_rt"

  Private_rt_name       = "Private_rt"
  
}
