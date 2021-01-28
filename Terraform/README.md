# MentoringProgram
## Task
Terraform vs CloudFormation task:
Create an application stack:
Networking – 1 VPC in us-east-1, 4 subnets (2 private and 2 public in different AZs), Internet GW <br>
Application – EC2 instance (AMI: ubuntu20.04, preconfigure Apache web server with a simple web-site), S3 bucket which should be accessible only from EC2 instance with a web server, not from the world, Security Group for an instance (SSH enabled from your home’s network, HTTP and HTTPS enabled from the world), application load balancer attached to the instance. EC2 instance should in a public subnet. <br>
You should have a cron job on the instance which should copy a web site content to S3 bucket every day. <br>
Please note, that for terraform configuration you should have a remote state with s3 bucket backend (separate from a bucket for web content backups). DynamoDB lock table for a remote state is optional. <br>
For both CF and TF tasks please use separate files, do not put all code in one file. You should split your code in a correct way which will be useful and comfortable.
![1](https://user-images.githubusercontent.com/55128761/91656002-ce5ad800-eabd-11ea-888a-fff59d7ced87.jpg)
![Web App Reference Architecture (1)](https://user-images.githubusercontent.com/55128761/106191786-fad16800-61b3-11eb-897a-54ee091b455b.png)

### ApplicationLoadBalancer with apache shows ip from first ec2 instance
![alb1](https://user-images.githubusercontent.com/55128761/106184643-80e8b100-61aa-11eb-91bc-d6beaa12b4b6.jpg)

### ApplicationLoadBalancer with apache shows ip from second ec2 instance
![alb2](https://user-images.githubusercontent.com/55128761/106184646-8219de00-61aa-11eb-92bd-88457779b894.jpg)

### Back up web page to the s3 bucket (one minute interval for crone just for example)
![s3_for_backup](https://user-images.githubusercontent.com/55128761/106184649-8219de00-61aa-11eb-9991-50862a9f5742.jpg)

### Terraform saves terraform.tfstate file in the s3 bucket
![s3_for_tf_state](https://user-images.githubusercontent.com/55128761/106184653-83e3a180-61aa-11eb-881f-984dbc97d4f5.jpg)
