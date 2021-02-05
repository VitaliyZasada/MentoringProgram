####################################################
# Variables for AWS region
####################################################
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

####################################################
# Variables for tags
####################################################
variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Owner       = "vvs",
    Environment = "dev"
  }
}

####################################################
# Variables for s3 module and backend
####################################################
variable "s3_backup_name" {
  description = "Name of the s3 bucket where web content will be stored"
  type        = string
  default     = "homework-vvs-s3-webpage-backup"
}

####################################################
# Variables for keys module
####################################################
variable "key_name" {
  type    = string
  default = "test_key"
}

variable "public_key" {
  type    = string
  default = "/home/vitaliy/.ssh/test_key.pub"
}

####################################################
# Variables for VPC module
####################################################
variable "vpc_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "vps-for-app"
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "azs_count" {
  description = "Number of azs"
  type        = number
  default     = 2
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default     = 2
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
  default     = 2
}

####################################################
# Variables for SG module
####################################################
variable "user_cidr_blocks" {
  description = "A list of user cidr blocks for SG"
  type        = string
  default     = "92.112.186.106/32"
}

####################################################
# Variables for ApplicationLoadBalancer module
####################################################
variable "alb_name" {
  description = "Name of the ALB"
  type        = string
  default     = "alb"
}

variable "load_balancer_type" {
  description = "ALB type"
  type        = string
  default     = "application"
}

####################################################
# Variables for AutoScalingGroup module
####################################################
variable "ec2_private_name" {
  description = "Creates a unique name beginning with the specified prefix"
  type        = string
  default     = "ec2-with-apache"
}

variable "lc_private_name" {
  description = "Creates a unique name for launch configuration beginning with the specified prefix"
  type        = string
  default     = "ec2-with-apache"
}

variable "asg_private_name" {
  description = "Creates a unique name for autoscaling group beginning with the specified prefix"
  type        = string
  default     = "asg-for-apache"
}

variable "ec2_public_name" {
  description = "Creates a unique name beginning with the specified prefix"
  type        = string
  default     = "ec2-bastion"
}

variable "lc_public_name" {
  description = "Creates a unique name for launch configuration beginning with the specified prefix"
  type        = string
  default     = "ec2-bastion"
}

variable "asg_public_name" {
  description = "Creates a unique name for autoscaling group beginning with the specified prefix"
  type        = string
  default     = "asg-for-bastion"
}

# Launch configuration
variable "image_id" {
  description = "The EC2 image ID to launch, ubuntu 20.04"
  type        = string
  default     = "ami-0885b1f6bd170450c"
}

variable "instance_type" {
  description = "The size of instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "root_block_device" {
  type = map
  default = {
    "volume_size" = "10"
    "volume_type" = "gp2"
  }
}