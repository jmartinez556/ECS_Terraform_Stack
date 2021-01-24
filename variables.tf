variable "region" {
  type    = string
  default = "us-east-1"
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "associate_public_ip_address" {
  type    = string
  default = "true"
}
variable "vpc_cidr_block" {
  type    = string
  default = "10.200.0.0/16"
}
# PUBLIC SUBNETS
variable "public_subnet_1_cidr_block" {
  type    = string
  default = "10.200.3.0/24"
}
variable "public_subnet_2_cidr_block" {
  type    = string
  default = "10.200.1.0/24"
}
variable "public_subnet_3_cidr_block" {
  type    = string
  default = "10.200.4.0/24"
}
# PRIVATE SUBNETS
variable "private_subnet_1_cidr_block" {
  type    = string
  default = "10.200.2.0/24"
}
variable "private_subnet_2_cidr_block" {
  type    = string
  default = "10.200.5.0/24"
}
variable "private_subnet_3_cidr_block" {
  type    = string
  default = "10.200.6.0/24"
}
variable "desired_capacity" {
  type    = number
  default = 1
}
variable "max_size" {
  type    = number
  default = 1
}
variable "min_size" {
  type    = number
  default = 1
}

variable "domain" {
  type = string
}
variable "container_name" {
  type = string
}
variable "container_port" {
  type = number
}
//variable "container_image" {
//  type = string
//}
variable "hosted_zone_id" {
  type = string
}
variable "subdomain" {
  type = string
}
variable "record_type" {
  type    = string
  default = "A"
}
variable "container_image" {
  type = string
}
variable "app_name" {
  type = string
}






