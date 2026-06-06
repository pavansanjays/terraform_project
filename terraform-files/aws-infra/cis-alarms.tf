resource "aws_cloudwatch_log_group" "cis-log-grp" {
  name = "cis-log-group"
}

module "cloudwatch_cis-alarms" {
source  = "terraform-aws-modules/cloudwatch/aws//modules/cis-alarms"
version = "5.7.2"

  disabled_controls = [
    "disabled-or-deleted-cmk",
    "vpc-changes"
  ]

  create = false 

log_group_name = aws_cloudwatch_log_group.cis-log-grp.name
alarm_actions = [aws_sns_topic.my-sns-topic.arn]
tags=local.common-tags

}
