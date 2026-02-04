terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_user" "name" {
  name="kir"
}

locals {
  instancemap={
    default= "t2"
    dev="t3"
    prod="t4"
  }
}

# resource "aws_instance" "name" {
#   instance_type = local.instancemap[terraform.workspace]
# }
output "name" {
  value = local.instancemap[terraform.workspace]
}