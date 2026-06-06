# terraform {
#   backend "s3" {

#     bucket         = "hr-terraform-state-demo-12345"
#     key            = "project/terraform.tfstate"
#     region         = "ap-south-1"
#     dynamodb_table = "terraform-locks"

#     encrypt = true
#   }
# }

# ///always backend must contins hardcore no varibles becuase it is created at first so no var, aws.nmae etc...
# //so change this name in the dynamo tbale and s3 as hardcoded.