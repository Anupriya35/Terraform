
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


#aws-provider

provider "aws" {
    region = "us-east-2"
    access_key = "access key"
    secret_key = "secret key"
}

#step 1 - VPC creation

resource "aws_vpc" "demo-vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      "Name" = "vpc demo"
    }
  }

  # step 2 - internet Gateway creation

  resource "aws_internet_gateway" "igw" {
    vpc_id  = aws_vpc.demo-vpc.id
  }

# step 3 - route table creation

resource "aws_route_table" "demo-route-table" {
    vpc_id = aws_vpc.demo-vpc.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "demo"
    }
  
}

#step 4 - subnet creation

resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
      Name = "demo-subnet1"
  }
}

# step 5 - associate subnet with RT

resource "aws_route_table_association" "RTassociation" {
    subnet_id = aws_subnet.subnet-1.id
    route_table_id = aws_route_table.demo-route-table.id
  
}

# step 6 - security groups creation 

resource "aws_security_group" "demo-sec-groups" {
    vpc_id = aws_vpc.demo-vpc.id
    name    = "allow_traffic"
    description = "allow inbound traffic"

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =["0.0.0.0/0"]
    
    }
    egress {
        from_port = 0
        to_port     =0
        protocol ="-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags    ={
        Name = "allow_ports"
    }
  
}

# step 7 - create network interface


resource "aws_network_interface" "nic" {
    subnet_id = aws_subnet.subnet-1.id
    private_ips = ["10.0.1.30"]
    security_groups = [ aws_security_group.demo-sec-groups.id]
}
  
# step 8 - elastic IP to nic

resource "aws_eip" "eip1" {
    vpc = true
    network_interface = aws_network_interface.nic.id
    associate_with_private_ip = "10.0.1.30"
    depends_on = [aws_internet_gateway.igw]
  
}


# Ubuntu server creation

resource "aws_instance" "ubuntu-instance" {
  ami = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  availability_zone = "us-east-2a"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.nic.id
  }

 /* user_data =<<-EOF #!/bin/bash

                sudo apt install curl
                curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

                sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" 
                sudo apt update
                sudo apt install terraform
                EOF
                
  tags={
      Name = "Terraform"
                } */

}
