module "alb-security-group" {
    source  = "terraform-aws-modules/security-group/aws"
    version = "5.3.1"

    name = "alb-security-group"
    description = "this is security group for public server"
    vpc_id =  module.import-vpc.vpc-id
    ingress_rules = ["ssh-tcp","https-443-tcp"]
    ingress_cidr_blocks = ["0.0.0.0/0"]
    ingress_with_cidr_blocks = [ 
        {
            from_port=81
            to_port=81
            protocol    = "tcp"
            description = "HTTP 81"
            cidr_blocks = "0.0.0.0/0"
        },
        {
            from_port=80
            to_port=80
            protocol    = "tcp"
            description = "HTTP 80"
            cidr_blocks = "0.0.0.0/0"
        }
    ]
     
    egress_rules = ["all-all"]
}