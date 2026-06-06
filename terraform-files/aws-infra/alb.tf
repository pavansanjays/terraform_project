module "aws-alb" {
  depends_on = [ module.import-vpc ]
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.0"

  name = "${local.name}-alb"
  load_balancer_type = "application"
  vpc_id = module.import-vpc.vpc-id
  security_groups = [module.alb-security-group.security_group_id]
  subnets = module.import-vpc.vpc-public-subnet
  enable_deletion_protection = false

  tags = local.common-tags

  listeners = {

    "my-https-listner"={
      port=80
      protocol="HTTP"
      
    //default action
      fixed_response={
        content_type="text/plain"
        message_body="this is fixed mesage"
        status_code=200
      }

      rules={
        "my-app1-rule"={
          priority = 1
          actions = [{
            weighted_forward = {
              target_groups = [
                {
                  target_group_key = "my-tg1"
                  weight           = 1
                }
              ]
              stickiness = {
                enabled  = true
                duration = 3600
              }
            }
          }]

          conditions = [{
            path_pattern = {
              values = ["/app1*"]
            } //this i path based now lets got for httpheader based rotuing

            # http_header={
            #    http_header_name="customername"
            #    values=["app1","app-1"]
            # }
          }]
        }


        "my-app2-rule"={
          priority = 2
          actions = [{
            weighted_forward = {
              target_groups = [
                {
                  target_group_key = "my-tg2"
                  weight           = 1
                }
              ]
              stickiness = {
                enabled  = true
                duration = 3600
              }
            }
          }]

          conditions = [{
            path_pattern = {
              values = ["/app2*"]
            }//this i path based now lets got for httpheader based rotuing

            # http_header={
            #    http_header_name="customername"
            #    values=["app2","app-2"]
            # }
          }]
        }

        "my-app3-rule"={
          priority = 3
          actions = [{
            weighted_forward = {
              target_groups = [
                {
                  target_group_key = "my-tg3"
                  weight           = 1
                }
              ]
              stickiness = {
                enabled  = true
                duration = 3600
              }
            }
          }]

          conditions = [{
            path_pattern = {
              values = ["/login*"]
            } //this i path based now lets got for httpheader based rotuing

            # http_header={
            #    http_header_name="customername"
            #    values=["app1","app-1"]
            # }
          }]
        }

        //THIS is rule for asg instances route traffic to path

        "my-app4-rule"={
          priority = 4
          actions = [{
            weighted_forward = {
              target_groups = [
                {
                  target_group_key = "my-tg4"
                  weight           = 1
                }
              ]
              stickiness = {
                enabled  = true
                duration = 3600
              }
            }
          }]

          conditions = [{
            path_pattern = {
              values = ["/launch*"]
            } //this i path based now lets got for httpheader based rotuing

            # http_header={
            #    http_header_name="customername"
            #    values=["app1","app-1"]
            # }
          }]
        }


      }
    }
  }

  target_groups = {
    "my-tg1"={  //we are tranfer to this tg1
        name_prefix="mytg1"
        protocol="HTTP"
        port=80
        target_type="instance"
        deregistration_delay=10
        load_balancing_cross_zone_enabled=false
        protocol_version="HTTP1"
        create_attachment=false  //dont attche tg to any ec2

        health_check={
          enabled=true 
          path="/app1/index.html"
          healthy_threshold=3
          unhealthy_threshold=3
          interval=30
          timeout=6
          matcher="200-299"

          port="traffic-port"
          protocol="HTTP"
        }
    }

     "my-tg2"={  //we are tranfer to this tg1
        name_prefix="mytg2"
        protocol="HTTP"
        port=80
        target_type="instance"
        deregistration_delay=10
        load_balancing_cross_zone_enabled=false
        protocol_version="HTTP1"
        create_attachment=false  //dont attche tg to any ec2

        health_check={
          enabled=true 
          path="/app2/index.html"
          healthy_threshold=3
          unhealthy_threshold=3
          interval=30
          timeout=6
          matcher="200-299"

          port="traffic-port"
          protocol="HTTP"
        }
    }
    

     "my-tg3"={  //we are tranfer to this tg1
        name_prefix="mytg3"
        protocol="HTTP"
        port=80 //apche our server in ec2 alwys listens on 80 so give ort 80 it will check there
        target_type="instance"
        deregistration_delay=10
        load_balancing_cross_zone_enabled=false
        protocol_version="HTTP1"
        create_attachment=false  //dont attche tg to any ec2

        health_check={
          enabled=true 
          path="/login/"
          healthy_threshold=3
          unhealthy_threshold=3
          interval=30
          timeout=6
          matcher="200-299"

          port="traffic-port"
          protocol="HTTP"
        }
    }

    //this tg is for asg ruote traffic

    "my-tg4"={  //we are tranfer to this tg1
        name_prefix="mytg4"
        protocol="HTTP"
        port=80 //apche our server in ec2 alwys listens on 80 so give ort 80 it will check there
        target_type="instance"
        deregistration_delay=10
        load_balancing_cross_zone_enabled=false
        protocol_version="HTTP1"
        create_attachment=false  //dont attche tg to any ec2

        health_check={
          enabled=true 
          path="/launch/index.html"
          healthy_threshold=3
          unhealthy_threshold=3
          interval=30
          timeout=6
          matcher="200-299"

          port="traffic-port"
          protocol="HTTP"
        }
    }

  }
}

resource "aws_lb_target_group_attachment" "mytg1-attach" { //atach tg to traget i.e ec2
  for_each = {for instance,instance_att in module.app1-instace-private: instance=>instance_att}
  target_group_arn = module.aws-alb.target_groups["my-tg1"].arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "mytg2-attach" { //atach tg to traget i.e ec2
  for_each = {for instance,instance_att in module.app2-instace-private: instance=>instance_att}
  target_group_arn = module.aws-alb.target_groups["my-tg2"].arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "mytg3-attach" { //atach tg to traget i.e ec2
  for_each = {for instance,instance_att in module.app3-instace-private: instance=>instance_att}
  target_group_arn = module.aws-alb.target_groups["my-tg3"].arn
  target_id        = each.value.id
  port             = 80
}

//above attchments means attch each ec2 to targetgroup 

//no need to add tachment to our t4 beaucse asg automatically cinfig into our tg4.
//beacuse we put be;ow block in asg to tg connect to asg i.e ec2
# target_group_arns = [
#   module.aws-alb.target_groups["my-tg4"].arn
# ]