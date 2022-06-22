#  VPC
resource "aws_vpc" "qa-prod-vpc" {
    cidr_block = "10.0.0.0/16"
    
    tags ={
        Name = "prod-vpc"
    }
}

#  Public Subnet
resource "aws_subnet" "prod-subnet-public-1" {
    vpc_id = "${aws_vpc.qa-prod-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true" 
    availability_zone = "ap-south-1a"
    tags ={
        Name = "prod-subnet-public-1"
    }
}

#  Public Subnet
resource "aws_subnet" "prod-subnet-public-2" {
    vpc_id = "${aws_vpc.qa-prod-vpc.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1b"
    tags ={
        Name = "prod-subnet-public-2"
    }
}

#  Private Subnet
resource "aws_subnet" "prod-subnet-private-1" {
    vpc_id = "${aws_vpc.qa-prod-vpc.id}"
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1a"
    tags ={
        Name = "prod-subnet-private-1"
    }
}

#  Private Subnet
resource "aws_subnet" "prod-subnet-private-2" {
    vpc_id = "${aws_vpc.qa-prod-vpc.id}"
    cidr_block = "10.0.4.0/24"
    availability_zone = "ap-south-1b"
    tags ={
        Name = "prod-subnet-private-2"
    }
}

#  Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.qa-prod-vpc.id}"

  tags = {
    Name = "main"
  }
}