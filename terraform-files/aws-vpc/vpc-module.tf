provider "aws" {
  region= var.region
}

module "vpc-2" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name = var.vpc-name
  cidr = var.vpc-cidr
  azs = var.vpc-az
  private_subnets = var.public-subnets-name
  public_subnets= var.private-subnets-name

  create_database_subnet_group = true
  create_database_subnet_route_table = true
  database_subnets = var.db-subnet-name

  create_database_nat_gateway_route = true
  create_database_internet_gateway_route = true

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support = true

  private_subnet_tags = {
    name="private-subnet-01"
  }

  public_subnet_tags = {
    name="public-subnets-01"
  }

  database_subnet_tags = {
    name="database-subnet-01"
  }

  tags = {
    owner="aws"
    environment="dev"
  }
}

