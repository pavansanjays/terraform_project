################################################################################
# Load Balancer
################################################################################

output "id" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.aws-alb.id
}

output "arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.aws-alb.arn
}

output "arn_suffix" {
  description = "ARN suffix of our load balancer - can be used with CloudWatch"
  value       = module.aws-alb.arn_suffix
}

output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.aws-alb.dns_name
}

output "zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records"
  value       = module.aws-alb.zone_id
}

################################################################################
# Listener(s)
################################################################################

output "listeners" {
  description = "Map of listeners created and their attributes"
  value       = module.aws-alb.listeners
}

output "listener_rules" {
  description = "Map of listeners rules created and their attributes"
  value       = module.aws-alb.listener_rules
}

################################################################################
# Target Group(s)
################################################################################

output "target_groups" {
  description = "Map of target groups created and their attributes"
  value       = module.aws-alb.target_groups
}

