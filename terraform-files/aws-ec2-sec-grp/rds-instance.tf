module "db_instance" {
source  = "terraform-aws-modules/rds/aws"
version = "7.2.0"

identifier = var.db_instance_identifier
db_name = var.db_name
username = var.username
password_wo = var.password
password_wo_version = 1
port = 3306
multi_az = false
//subnet_ids = module.import-vpc.vpc-db-subnets //this is ignored by rds so usesubnet sbelow two lines
vpc_security_group_ids = [module.db-security-group-bastion.security_group_id] 

///asabovesubnets is ignoeddby rds so use this new subnets from our vpc
create_db_subnet_group = true
subnet_ids             = module.import-vpc.vpc-db-subnets

//about engine
engine = "mysql"
engine_version = "8.0"
family = "mysql8.0"
major_engine_version = "8.0"
instance_class = "db.t3.micro"
allocated_storage = 20
max_allocated_storage = 100
storage_encrypted = false

manage_master_user_password = false //meas mange passsword by me not aws/rds

maintenance_window = "Mon:00:00-Mon:03:00"
backup_window      = "03:00-06:00"
enabled_cloudwatch_logs_exports = ["error", "general"]
  

backup_retention_period = 0
skip_final_snapshot = true
deletion_protection = false

//performance
performance_insights_enabled = false 
//performance_insights_retention_period = 7
create_monitoring_role = true 

monitoring_interval = 60

parameters = [
    {
      name  = "max_connections"
      value = "100"
    }
] //it means atmost db connects to 100 people at sametime

tags = local.common-tags

}
