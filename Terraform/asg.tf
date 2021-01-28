####################################################
# AutoScaling groups for web servers and bastion
####################################################
module "private_asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name = var.ec2_private_name

  # Launch configuration
  lc_name = var.lc_private_name

  image_id             = var.image_id
  instance_type        = var.instance_type
  security_groups      = [module.private-sg.this_security_group_id]
  key_name             = module.public_key.this_key_pair_key_name
  iam_instance_profile = aws_iam_instance_profile.role_for_servers.name
  user_data            = <<-EOF
                            #!/bin/bash
                            apt-get update -y
                            apt install awscli -y            
                            ec2_ips=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
                            echo "<h1>$ec2_ips</h1>" > index.html
                            nohup busybox httpd -f -p 80 &
                            echo '*/1 * * * * aws s3 cp /index.html s3://homework-vvs-s3-webpage-backup/web-content/index.html' > /tmp/mycrontab.txt
                            bash -c 'crontab /tmp/mycrontab.txt'
                            EOF

  root_block_device = [
    {
      volume_size           = var.root_block_device.volume_size
      volume_type           = var.root_block_device.volume_type
      delete_on_termination = true
    },
  ]

  # Auto scaling group
  asg_name                  = var.asg_private_name
  vpc_zone_identifier       = module.vpc.private_subnets
  health_check_type         = "ELB"
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  target_group_arns         = module.alb.target_group_arns

  tags_as_map = var.resource_tags
}

module "public_asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name = var.ec2_public_name

  # Launch configuration
  lc_name = var.lc_public_name

  image_id        = var.image_id
  instance_type   = var.instance_type
  security_groups = [module.public-sg-bastion.this_security_group_id]
  key_name        = module.public_key.this_key_pair_key_name

  root_block_device = [
    {
      volume_size           = var.root_block_device.volume_size
      volume_type           = var.root_block_device.volume_type
      delete_on_termination = true
    },
  ]

  # Auto scaling group
  asg_name                  = var.asg_public_name
  vpc_zone_identifier       = module.vpc.public_subnets
  health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags_as_map = var.resource_tags
}

