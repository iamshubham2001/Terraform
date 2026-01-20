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

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = true


  tags = {
    Name = "MySubnet"
  }
}

resource "aws_security_group" "my_sg" {
  name        = "MySecurityGroup"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "myserver" {
    ami           = "ami-0683ee28af6610487" # Amazon Linux 2 AMI (eu-north-1)
    instance_type = "t3.micro"
    subnet_id = aws_subnet.my_subnet.id
    vpc_security_group_ids      = [aws_security_group.my_sg.id]
    associate_public_ip_address = true
    tags = {
        Name = "SampleServer"
    }
  
}