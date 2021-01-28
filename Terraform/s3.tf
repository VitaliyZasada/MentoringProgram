####################################################
# S3 bucket with policy where web-content will be backed up
####################################################
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.s3_backup_name
  acl    = "private"
  #block_public_acls = true

  force_destroy = true
  attach_policy = true

  tags = var.resource_tags

  versioning = {
    enabled = true
  }

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1611774072253",
    "Statement": [
        {
            "Sid": "Stmt1611774066122",
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": [
                "s3:Get*",
                "s3:List*",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::homework-vvs-s3-webpage-backup",
                "arn:aws:s3:::homework-vvs-s3-webpage-backup/*"
            ]
        }
    ]
}
   POLICY
}
