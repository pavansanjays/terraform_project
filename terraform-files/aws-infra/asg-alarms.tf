//create asg policy cpu policay for alram

resource "aws_autoscaling_policy" "high_cpu" { //it is optional
  
  name = "asgg-alram-${local.name}"
  scaling_adjustment = 4 //this alram means when trigers, this policy actions so scle upto 4
  cooldown = 300
  adjustment_type = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.my-asg.name
}

resource "aws_cloudwatch_metric_alarm" "asg_alaram" {
    alarm_name = "asg-alarm-${local.name}"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CpuUtilisation"
    namespace = "AWS/EWS"
    period = 120
    threshold = 80
    statistic = "Sum"
    dimensions = {
      autoscaling_group_name=aws_autoscaling_group.my-asg.name 
      //based on these as instaces alrm is checking threshold and trigger alrm
    }

    alarm_description = "this alarm trigered based on asg cpu trshold"

    alarm_actions = [aws_sns_topic.my-sns-topic.arn,aws_autoscaling_policy.high_cpu.arn]
    // triggers to asg policy so scle upto 4 and sns to send emial
    
}


