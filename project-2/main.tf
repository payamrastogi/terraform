terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
}

#1. Create a vpc
resource "aws_vpc" "vpc-project-2-20220824-01" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-project-2-20220824-01"
  }
}

#2. Create an internet gateway so that we can send traffic out in the internet
resource "aws_internet_gateway" "igw-project-2-20220824-01" {
  vpc_id = aws_vpc.vpc-project-2-20220824-01.id

  tags = {
    Name = "igw-project-2-20220824-01"
  }
}

#3. Create a custom route table 
resource "aws_route_table" "rtb-project-2-20220824-01" {
  vpc_id = aws_vpc.vpc-project-2-20220824-01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-project-2-20220824-01.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.igw-project-2-20220824-01.id
  }

  tags = {
    Name = "rtb-project-2-20220824-01"
  }
}
#4. Create a subnet
resource "aws_subnet" "subnet-project-2-20220824-01" {
  vpc_id     = aws_vpc.vpc-project-2-20220824-01.id
  cidr_block = var.cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-project-2-20220824-01"
  }
}

#5. Associate subnet with the route table
resource "aws_route_table_association" "rtba-project-2-20220824-01" {
  subnet_id      = aws_subnet.subnet-project-2-20220824-01.id
  route_table_id = aws_route_table.rtb-project-2-20220824-01.id
}
#6. Create a security group allow 22, 80, 443
resource "aws_security_group" "sg-project-2-20220824-01" {
  name        = "allow-web-sg-project-2-20220824-01"
  description = "Allow 22, 80, 443"
  vpc_id      = aws_vpc.vpc-project-2-20220824-01.id

  ingress {
    description      = "Https traffic"
    #Range of ports on which traffic is allowed
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Http traffic"
    #Range of ports on which traffic is allowed
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "SSH traffic"
    #Range of ports on which traffic is allowed
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    # Any protocol -1
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-project-2-20220824-01-Allow-Web"
  }
}

#7. Create a network interface with an ip in the subnet
resource "aws_network_interface" "ni-project-2-20220824-01" {
  subnet_id       = aws_subnet.subnet-project-2-20220824-01.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.sg-project-2-20220824-01.id]
}

#8. Assign an elastic ip to the network interface
resource "aws_eip" "eip-project-2-20220824-01" {
  network_interface = aws_network_interface.ni-project-2-20220824-01.id
  vpc      = true
  associate_with_private_ip = "10.0.1.50"
  depends_on = [
    aws_internet_gateway.igw-project-2-20220824-01
  ]
}

#9. Create an ubuntu server and install/enable Apache2
resource "aws_instance" "ubuntu_instance-project-2-20220824-01" {
  ami           = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  ##if not hard coded aws will random az
  availability_zone = "us-east-1a"
  key_name = "20220824-project-2-key"
  
  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.ni-project-2-20220824-01.id
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo update install -y
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo bash -c 'echo test > /var/www/html/index.html'
              EOF
  tags = {
    Name = "ubuntu_instance-project-2-20220824-01"
  }
}