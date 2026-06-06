resource "aws_eip" "aws-eip" {
  instance = module.ec2-instace-public.id
  domain = "vpc"
  tags = local.common-tags
}
