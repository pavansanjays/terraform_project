variable "vpc-name" {
  type = string
  default = "my-vpc-2"
}

variable "vpc-cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "vpc-az" {
  type = list(string)
  default = ["ap-south-1a","ap-south-1b"]
}

variable "public-subnets-name" {
  type = list(string)
  default = ["10.0.1.0/24","10.0.6.0/24"]
}

variable "private-subnets-name" {
  type = list(string)
  default = ["10.0.2.0/24","10.0.5.0/24"]
}

variable "db-subnet-name" {
  type = list(string)
  default = ["10.0.3.0/24","10.0.4.0/24"]
}