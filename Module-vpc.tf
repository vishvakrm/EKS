provider "aws" {
    region = var.aws_region
  
}

locals {
  cluster_name ="vis-eks-${random_string.suffix.results}"
}
resource "random_string" "suffix" {
  length = 8
  special = false
}

module "VPC" {
    source = "terraform-aws-modules/vpc/aws"

    name = "vis-eks-vpc"
    cidr = var.vpc_cidr

    azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  
    tags = {
        terraform = "true"
        Environment = "dev"
    }
}
