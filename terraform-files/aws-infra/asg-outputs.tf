output "launch_template_id" {
  value = aws_launch_template.my-launch-template.id
}

output "lauch_template_version" {
  value = aws_launch_template.my-launch-template.default_version
}

output "asg_groupd_id" {
  value = aws_autoscaling_group.my-asg.id
}

output "asg_name" {
  value = aws_autoscaling_group.my-asg.name
}

output "asg_arn" {
  value = aws_autoscaling_group.my-asg.arn
}