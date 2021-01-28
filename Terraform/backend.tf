####################################################
# Backend for tf.state on the AWS s3
####################################################
terraform {
  backend "s3" {
    bucket = "final.task.vvs"
    key    = "tfstate/terraform.tfstate"
    region = "eu-central-1"
  }
}