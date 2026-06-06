output "public-security-group-id" {
  value = module.public-security-group-bastion.security_group_id
}

output "private-security-group-id" {
  value = module.private-security-group-bastion.security_group_id
}

output "db-security-group-id" {
  value = module.db-security-group-bastion.security_group_id
}

output "vpc-id" {
  value = module.private-security-group-bastion.security_group_vpc_id
}