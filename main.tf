terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.76.0"
    }
  }
}
provider "aws" {
shared_config_files      = ["/Users/tf_user/.aws/conf"]
shared_credentials_files = ["/Users/tf_user/.aws/creds"]
AWS_PROFILE                 = "customprofile"
region = "ap-south-1"
}
resource "aws_vpc" "tf_vpc" {
cidr_block = "10.0.0.0/16"
enable_dns_hostnames = true
enable_dns_support = true
tags = {
Name = "tf_project_vpc"
}
}
resource "aws_subnet" "tf_subnet" {
cidr_block = "10.0.1.0/26"
vpc_id = aws_vpc.tf_vpc.id
map_public_ip_on_launch = true
availability_zone = "ap-south-1b"
tags = {
Name = "tf_project_subnet_1b"
}
}
resource "aws_instance" "tf_instance" {
count = 1
ami = "ami-022ce6f32988af5fa"
instance_type = "t2.medium"
availability_zone = "ap-south-1b"
subnet_id = aws_subnet.tf_subnet.id
tags = {
Name="tf_bhadra_server" }
}
