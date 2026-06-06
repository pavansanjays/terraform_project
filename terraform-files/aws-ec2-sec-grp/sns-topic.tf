resource "aws_sns_topic" "my-sns-topic" {
  name = "${local.environment}-my-sns"
} //our sns name 

resource "aws_sns_topic_subscription" "my-sns-subscription" {
  topic_arn = aws_sns_topic.my-sns-topic.arn
  protocol = "email"
  endpoint = "pavanburada8@gmail.com"
}

resource "aws_autoscaling_notification" "my-sns-notification" {
  group_names = [aws_autoscaling_group.my-asg.name] //when change in these send msg to sns tpic
 notifications = [
  "autoscaling:EC2_INSTANCE_LAUNCH",
  "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
  "autoscaling:EC2_INSTANCE_TERMINATE",
  "autoscaling:EC2_INSTANCE_TERMINATE_ERROR"
  ] //these actions then send msg
  topic_arn = aws_sns_topic.my-sns-topic.arn
} //linking asg to sns