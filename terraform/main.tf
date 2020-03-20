provider "aws" {
  region = "eu-central-1"
}

variable "web_server_1_name" {
  type    = string
  default = "web1"
}

variable "web_server_2_name" {
  type    = string
  default = "web2"
}

variable "load_balancer_name" {
  type    = string
  default = "load balancer"
}

variable "database_server_name" {
  type    = string
  default = "database"
}

variable "public_key" {
  type    = string
}

resource "aws_instance" "web_server_1" {
  ami             = "ami-0b418580298265d5c" # ubuntu 18.04
  instance_type   = "t2.micro"
  key_name        = "bonzo"
  security_groups = ["production_sg"]
  tags = {
    Name = var.web_server_1_name
  }
}

resource "aws_instance" "web_server_2" {
  ami             = "ami-0b418580298265d5c" # ubuntu 18.04
  instance_type   = "t2.micro"
  key_name        = "bonzo"
  security_groups = ["production_sg"]
  tags = {
    Name = var.web_server_2_name
  }
}

resource "aws_instance" "load_balancer" {
  ami             = "ami-0b418580298265d5c" # ubuntu 18.04
  instance_type   = "t2.micro"
  key_name        = "bonzo"
  security_groups = ["production_sg"]
  tags = {
    Name = var.load_balancer_name
  }
}

resource "aws_instance" "database" {
  ami             = "ami-0b418580298265d5c" # ubuntu 18.04
  instance_type   = "t2.micro"
  key_name        = "bonzo"
  security_groups = ["production_sg"]
  tags = {
    Name = var.database_server_name
  }
}


resource "aws_key_pair" "bonzo" {
  key_name   = "bonzo"
  public_key = var.public_key
}

resource "aws_security_group" "production" {
  name        = "production_sg"
  description = "production_sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

