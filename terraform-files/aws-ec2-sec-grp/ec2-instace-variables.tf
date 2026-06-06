# variable "aws-ami" {
#   type = string
#  // default = "${data.aws_ami.id}"
# }

variable "instace-type" {
  type = string
  default = "t3.micro"
}
variable "instance-keyname" {
  type=string
  default = "pavan1"
}
variable "private-instace-count" {
  type = number
  default = 2
}

variable "region" {
  type = string
  default = "ap-south-1"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "bussiness-division" {
  type = string
  default = "HR"
}

