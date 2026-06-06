module "public-security-group-bastion" {
    source  = "terraform-aws-modules/security-group/aws"
    version = "5.3.1"

    name = "public-security-group-bastion"
    description = "this is security group for public server"
    vpc_id =  module.import-vpc.vpc-id
    ingress_rules = ["ssh-tcp","http-80-tcp"]
    ingress_cidr_blocks = ["0.0.0.0/0"]
 
    egress_rules = ["all-all"]
}