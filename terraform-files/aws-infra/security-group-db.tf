  module "db-security-group-bastion" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  name        = "db-security-group-bastion"
  description = "this is security group for db server"
  vpc_id      = module.import-vpc.vpc-id

  ingress_with_source_security_group_id = [
    {
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      description              = "Allow priavte ec2 for users  and public ec2 for developrs "
      source_security_group_id = module.private-security-group-bastion.security_group_id
    },
    {
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      description              = "Allow priavte ec2 for users  and public ec2 for developrs "
      source_security_group_id = module.public-security-group-bastion.security_group_id
    }
  ]

  egress_rules = ["all-all"]
}