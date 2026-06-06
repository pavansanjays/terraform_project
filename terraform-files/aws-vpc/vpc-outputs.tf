output "vpc-id" {
  value = module.vpc-2.vpc_id
}

output "vpc-cidr" {
  value= module.vpc-2.vpc_cidr_block
}

output "vpc-az" {
  value = module.vpc-2.azs
}

output "vpc-public-subnet" {
  value = module.vpc-2.public_subnets
}

output "vpc-private_subnets" {
 value=module.vpc-2.private_subnets 
}
output "vpc-db-subnets" {
  value = module.vpc-2.database_subnets
}