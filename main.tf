terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
    region = "eu-north-1"  
}

resource "aws_instance" "myserver" {
    ami           = "ami-0683ee28af6610487" # Amazon Linux 2 AMI (eu-north-1)
    instance_type = "t3.micro"
    
    tags = {
        Name = "SampleServer"
    }
  
}