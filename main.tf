data "aws_ami" "ami_name" {
  owners      = [var.ami_owner_id] #ami owner
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami_name]
  }
}
data "aws_vpc" "my_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "priv_subnet_1" {
  filter {
    name   = "tag:Name"
    values = [var.priv_subnet_name_1]
  }
}

data "aws_subnet" "priv_subnet_2" {
  filter {
    name   = "tag:Name"
    values = [var.priv_subnet_name_2]
  }
}

data "aws_subnet" "pub_subnet_1" {
  filter {
    name   = "tag:Name"
    values = [var.pub_subnet_name_1]
  }
}

data "aws_subnet" "pub_subnet_3" {
  filter {
    name   = "tag:Name"
    values = [var.pub_subnet_name_3]
  }
}