locals {
  name="${module.import-vpc.vpc-id}-${var.bussiness-division}"
  owner=var.bussiness-division
  environment=var.environment
  common-tags={
       owner=local.owner
       environment=local.environment
  }
}