variable "name_blue" {
    description = "name of a blue ASG instances"
}

variable "name_green" {
    description = "name of a green ASG instances"
}
variable "ami_owner_id" {
    description = "ID of ami owner"
}
variable "ami_name" {
    description = "Name of ami"
}
variable "instance_type" {
    description = "type of instance for ec2"
}
variable "keypair_name" {
    description = "name of the keypair"
}
variable "vpc_name" {
    description = "name of vps where the infrastructure is deployed"
}
variable "priv_subnet_name_1" {
    description = "name of a private subnet 1"
}
variable "priv_subnet_name_2" {
    description = "name of a private subnet 2"
}