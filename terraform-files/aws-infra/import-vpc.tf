provider "aws" {
  region= "ap-south-1"
}
module "import-vpc" {
  source = "../aws-vpc"
}