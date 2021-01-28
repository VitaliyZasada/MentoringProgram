####################################################
# IAM role and policy for web serves to access to s3
####################################################
data "aws_iam_policy_document" "access_for_servers" {
  statement {
    sid       = "WriteAccess"
    effect    = "Allow"
    resources = ["${module.s3_bucket.this_s3_bucket_arn}/*"]

    actions = [
      "s3:PutObject"
    ]
  }
}

data "aws_iam_policy_document" "s3_list" {
  statement {
    sid = "ListAccess"

    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]

    resources = ["*"]
    effect    = "Allow"
  }
}

module "role" {
  source = "cloudposse/iam-role/aws"

  enabled = true
  name    = "RoleForServers"

  policy_description = "Allow Access to S3"
  role_description   = "IAM role with permissions to perform actions on S3 resources"

  principals = {
    Service = ["autoscaling.amazonaws.com", "ec2.amazonaws.com"]
  }

  policy_documents = [
    data.aws_iam_policy_document.access_for_servers.json,
    data.aws_iam_policy_document.s3_list.json
  ]

  policy_document_count = 2

  tags = var.resource_tags

}

resource "aws_iam_instance_profile" "role_for_servers" {
  name = "RoleForServers"
  role = module.role.name
}