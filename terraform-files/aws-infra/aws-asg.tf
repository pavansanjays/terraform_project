resource "aws_autoscaling_group" "my-asg" {
  name = "${local.environment}-myasg"
  desired_capacity = 2
  max_size = 4
  min_size = 2
  vpc_zone_identifier = module.import-vpc.vpc-private_subnets
#   target_group_arns = [
#   for tg in module.aws-alb.target_groups : tg.arn
# ] //we can put multiple tgs but only one for now beaicse we have attach nly one policy yotg in asgpolicries i.e resource label
  target_group_arns = [module.aws-alb.target_groups["my-tg4"].arn]
// very important step here we connect tg to asg and alredy tg connected toalb

  health_check_grace_period = 300

  launch_template {
    id = aws_launch_template.my-launch-template.id
    version = aws_launch_template.my-launch-template.default_version
  }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      instance_warmup = 300
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity","launch_template"] // measn if e do change sin desired capticy then ASG refreshes all instances reflect in all onstcaes
     //threr are many triggers when desired capacity changes and db chnages, ip changes,user dat acnges etc..
  }

  tag {
    key = "Name"
    value = "asg-instace"

    propagate_at_launch = true //this measn these tages all goes to ec2 isntace also from asg
  }
}