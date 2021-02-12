# MentoringProgram
## Task
Terraform vs CloudFormation task:

Create an application stack:
Networking – 1 VPC in us-east-1, 4 subnets (2 private and 2 public in different AZs), Internet GW <br>

Application – EC2 instance (AMI: ubuntu20.04, preconfigure Apache web server with a simple web-site), S3 bucket which should be accessible only from EC2 instance with a web server, not from the world, Security Group for an instance (SSH enabled from your home’s network, HTTP and HTTPS enabled from the world), application load balancer attached to the instance. EC2 instance should in a public subnet. <br>

You should have a cron job on the instance which should copy a web site content to S3 bucket every day. <br>

Please note, that for terraform configuration you should have a remote state with s3 bucket backend (separate from a bucket for web content backups). DynamoDB lock table for a remote state is optional. <br>

For both CF and TF tasks please use separate files, do not put all code in one file. You should split your code in a correct way which will be useful and comfortable.

![cloudformation](https://user-images.githubusercontent.com/55128761/107796756-e1f3b580-6d62-11eb-9a52-f191eef168b5.png)
![Web App Reference Architecture (1)](https://user-images.githubusercontent.com/55128761/106191786-fad16800-61b3-11eb-897a-54ee091b455b.png)

### How to
1.
```bash
aws cloudformation package --template-file main.yml --s3-bucket <ExistingS3BucketName> --output-template-file packaged.yml
```
2.
```bash
aws cloudformation deploy --template-file /path/to/packaged.yml --stack-name test --capabilities CAPABILITY_NAMED_IAM
```
### After the second command is completed result must be similar to this:
![stacks](https://user-images.githubusercontent.com/55128761/107799598-495f3480-6d66-11eb-81ae-381c95534baa.jpg)

### Back up web page to the s3 bucket (one minute interval for crone just for example)
![s3_cf](https://user-images.githubusercontent.com/55128761/107799687-6b58b700-6d66-11eb-993d-55b9a407d34c.jpg)
