resource "aws_autoscaling_policy" "cpu_metric_policy" {
  name = "cpu_metric_policy"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.my-asg.name
  estimated_instance_warmup = 180

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0 //it means evrytime should maintain 50 or if greate than50 add instace and less than 50 delete instace
  }
  
}

//this is policy when requests increase then add instace else decrese but it is also ttsp policy
resource "aws_autoscaling_policy" "request_metric_policy" {
  name = "request_metric_policy"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.my-asg.name
  estimated_instance_warmup = 180

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label = "${module.aws-alb.arn_suffix}/${module.aws-alb.target_groups["my-tg4"].arn_suffix}"
      //here we alb sends traffic to tg and tg sends to ec2, so for this we connect ploicy to tg and alb
    }
    target_value = 10 //it means 10 requests for target
  }

  depends_on = [ aws_autoscaling_group.my-asg,module.aws-alb]
  
}

# Required instances ≈ Total load / target_value
# Target = 10 requests per instance
# Total traffic = 25 requests
# 👉 Needed:

# 25 / 10 = ~3 instances

# 👉 If you have 2:

# ASG → increases to 3 (adds 1)


 //scdhule to increase when 9am
resource "aws_autoscaling_schedule" "capacity_increase_9am" {
  scheduled_action_name = "scale-up"
  min_size = 2
  max_size = 4
  desired_capacity = 3
 recurrence = "0 9 * * *"  # 9:00 AM every day
 autoscaling_group_name = aws_autoscaling_group.my-asg.name
}

//schudle to deacre at 9pm 
resource "aws_autoscaling_schedule" "capacity_decrease_9pm" {
  scheduled_action_name = "scale-down"
  min_size = 2 //in all polices min size must not below asg min
  max_size = 4 //in all policies max size must not mne aboe max
  desired_capacity = 2
  autoscaling_group_name = aws_autoscaling_group.my-asg.name
  recurrence = "0 22 * * *"  # 10:00 PM every day"
}


# Auto Scaling Group (ASG)
#    ├─ Scaling Policy  → reacts to metrics (CPU, requests, etc.) ttsp,step scaling policy
#    └─ Scheduled Action → runs at specific times

