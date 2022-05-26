variable "vpc_cidr_block" {
    type = string
    description = "CIDR block used in our VPC"
    default = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
    type = list(string)
    description = "CIDR block used for public subnet"
    default = ["10.0.1.0/24"]
}

variable "private_subnets_cidr" {
    type = list(string)
    description = "CIDR block used for public subnet"
    default = ["10.0.2.0/24"]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${terraform.workspace}-vpc"
  cidr = var.vpc_cidr_block

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Environment = "dev"
  }
}