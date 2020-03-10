provider "aws" {
  region = "eu-central-1"
}

variable "server_name" {
  type    = string
  default = "terraform_example"
}

variable "public_key" {
  type    = string
}

### example instance
resource "aws_instance" "example" {
  ami             = "ami-0b418580298265d5c" # ubuntu 18.04
  instance_type   = "t2.micro"
  key_name        = "bonzo"
  security_groups = ["example_sg"]
  tags = {
    Name = var.server_name
  }
}

resource "aws_key_pair" "bonzo" {
  key_name   = "bonzo"
  public_key = var.public_key
}

resource "aws_security_group" "example" {
  name        = "example_sg"
  description = "example_sg"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

