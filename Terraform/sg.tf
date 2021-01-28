####################################################
# Security groups for bastion, for web servers and ALB
####################################################
module "public-sg-bastion" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "public-sg-bastion"
  description = "Security group for public access to bastion"
  vpc_id      = module.vpc.vpc_id

  egress_rules = ["all-all"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh for bastion"
      cidr_blocks = var.user_cidr_blocks
    }
  ]
  tags = var.resource_tags
}

module "private-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "private-sg"
  description = "Security group for ssh and auto-scaling"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["https-443-tcp", "http-80-tcp", "ssh-tcp", "all-icmp"]
  egress_rules        = ["all-all"]

  tags = var.resource_tags
}

module "public-sg-alb" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "public-sg-alb"
  description = "Security group for ALB"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]
  egress_rules        = ["all-all"]

  tags = var.resource_tags
}