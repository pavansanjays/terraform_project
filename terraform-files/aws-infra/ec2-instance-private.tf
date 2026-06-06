# module "ec2-instace-private" {
#   source = "terraform-aws-modules/ec2-instance/aws"

#   name  = "${var.environment}-private"
#   //count = var.private-instace-count

#   ami                    = data.aws_ami.aws_ami.id
#   instance_type          = var.instace-type
#   key_name               = var.instance-keyname
#   monitoring             = true
#   vpc_security_group_ids = [module.private-security-group-bastion.security_group_id]


#   //subnet_id = module.import-vpc.vpc-private_subnets[0]-- this is old for new use the foe-each loop

#   for_each = toset(["0","1"])
#   subnet_id = element(module.import-vpc.vpc-private_subnets,tonumber(each.key)) //here subnet-id take only one subnet so giving all subnets by for loop

#  user_data = each.key == "0" ? file("${path.module}/app1-install.sh") : file("${path.module}/app2-install.sh")

#   depends_on = [ module.import-vpc ]

#   tags = local.common-tags

# }