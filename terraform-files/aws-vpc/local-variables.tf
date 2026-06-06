locals {
  name="${var.vpc-name}-${var.bussiness-division}"
  owner=var.bussiness-division
  environment=var.environment
  common-tags={
       owner=local.owner
       environment=local.environment
  }
}