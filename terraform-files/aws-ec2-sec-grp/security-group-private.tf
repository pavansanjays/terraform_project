module "private-security-group-bastion" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  name        = "private-security-group-bastion"
  description = "this is security group for private server"
  vpc_id      = module.import-vpc.vpc-id

  ingress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      description              = "Allow ALB"
      source_security_group_id = module.alb-security-group.security_group_id //i.e we are alb aaccess to private ec2 to 80 port
    },
    {
      from_port                = 8080
      to_port                  = 8080
      protocol                 = "tcp"
      description              = "Allow ALB"
      source_security_group_id = module.public-security-group-bastion.security_group_id //ie. we are trying to accces from public ec2 to 8080port of private sever
    }
  ]

  egress_rules = ["all-all"]
}