####################################################
# SSH keys for access to ec2 instances
####################################################
module "public_key" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = var.key_name
  public_key = file(var.public_key)

  tags = var.resource_tags

}