module "ec2-instace-public" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name  = "${var.environment}-bastion"

  ami                    = data.aws_ami.aws_ami.id
  instance_type          = var.instace-type
  key_name               = var.instance-keyname
  monitoring             = true
  vpc_security_group_ids = [module.public-security-group-bastion.security_group_id]
  subnet_id = module.import-vpc.vpc-public-subnet[0]
  user_data = file("${path.module}/rds-develpoer-userdata.sh")
  tags = local.common-tags

}