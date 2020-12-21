variable "region" {
  type = string
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type = string
}
variable "associate_public_ip_address" {
  type    = string
  default = "true"
}
variable "vpc_cidr_block" {
  type    = string
  default = "10.200.0.0/16"
}
variable "availability_zone1" {
  type = string
}
variable "public_subnet_1_cidr_block" {
  type    = string
  default = "10.200.3.0/24"
}
variable "availability_zone2" {
  type = string
}
variable "public_subnet_2_cidr_block" {
  type    = string
  default = "10.200.1.0/24"
}
variable "private_subnet_1_cidr_block" {
  type    = string
  default = "10.200.2.0/24"
}
variable "desired_capacity" {
  type = number
}
variable "max_size" {
  type = number
}
variable "min_size" {
  type = number
}
variable "load_balancer_name" {
  type = string
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









