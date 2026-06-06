resource "aws_cloudwatch_metric_alarm" "alb-alarms" {
  alarm_name = "alb-alram-${local.name}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 3
  datapoints_to_alarm = 2
  period = 120
  statistic = "Sum"
  threshold = 5
  
  metric_name = "HTTPCode_ELB_4XX_Count"
  namespace = "AWS/ELB"
  treat_missing_data = "missing"

  dimensions = {
    ELB=module.aws-alb.arn
  }

  alarm_description = "this alarm is for alb for 4xx,5xx for both  alb,target..."

  alarm_actions = [aws_sns_topic.my-sns-topic.arn] //if trgiggger then send emial
  ok_actions = [aws_sns_topic.my-sns-topic.arn] //if alarm is ok then also send emial
}