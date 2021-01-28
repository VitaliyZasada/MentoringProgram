####################################################
# VPC, azs, subnets
####################################################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.cidr

  azs             = slice(var.azs, 0, var.azs_count)
  private_subnets = slice(var.private_subnets, 0, var.private_subnet_count)
  public_subnets  = slice(var.public_subnets, 0, var.private_subnet_count)


  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = var.resource_tags
}