resource "aws_launch_template" "my-launch-template" {
    name = "${local.environment}-my-launch-template"
    description = "This is templte for ec2 servers fro asg"
    image_id = data.aws_ami.aws_ami.id
    instance_type = var.instace-type
    vpc_security_group_ids = [module.private-security-group-bastion.security_group_id]
    key_name = var.instance-keyname
    user_data = base64encode(file("${path.module}/launch-template-userdata.sh"))
    ebs_optimized = true  //update ebs when ec2
    update_default_version = true //while changin versoin it update  new versoin as defualt version
    block_device_mappings {
      device_name = "/dev/sda1" //link ebs to ec2 at point /dev/sda1 but this is linking to our ec2 but we cant access ebs we have to od mount
      ebs {
        volume_size = 10
        volume_type = "gp2"
        delete_on_termination = true 
      }
    }

    monitoring {
      enabled = true 
    }

    tag_specifications {
      resource_type = "instance"
      tags = {
        Name="my-lauch-template"
      }
    }
}