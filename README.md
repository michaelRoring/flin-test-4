# flin-test-4

# Wordpress application on AWS

### Overview

This project is a simple architecture to host a Wordress aplication on AWS with scalable infrastructure. I wrote deploy.sh to setup the infrastructure. It is not a production ready solution, but it is a good starting point to start the infrastructure setup.

### Architecture summary

- EC2 instance in public subnet with Wordpress, Apache and PHP installed
- RDS instance using MySQL (future can be in private subnet)
- S3 bucket for static media file storage (via plugin)
- Cloudfront for caching and delivering static content from S3 bucket
- Basic VPC networking with internet access

### Benefits

- Scalable: EC2 can be scaled up with Auto Scaling Group in the future
- Efficient: Unload media delivery to Cloudfront CDN
- Modular: Each of the AWS resources is separated into its own module and can be extended independently
