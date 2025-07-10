terraform {
  required_version = "~> 1.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  
}
module "vpc" {
  source    = "./modules/vpc"
  region = var.region
  vpc_cidr  = var.vpc_cidr
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "web" {
  source             = "./modules/web"
  public_subnets     = module.vpc.public_subnets
  ami_id             = var.web_ami
  instance_type      = var.web_instance_type
  security_group_id  = module.security.web_sg_id
  web_key_name     = var.web_key_name
  web_private_key  = tls_private_key.rsa.private_key_pem
}

module "app" {
  source             = "./modules/app"
  private_subnets    = module.vpc.app_subnets
  ami_id             = var.app_ami
  instance_type      = var.app_instance_type
  security_group_id  = module.security.app_sg_id
  app_key_name     = var.app_key_name
  app_private_key  = tls_private_key.rsa.private_key_pem
}

module "db" {
  source             = "./modules/db"
  db_subnets         = module.vpc.db_subnets
  db_username        = var.db_username
  db_password        = var.db_password
  security_group_id  = module.security.db_sg_id
}

resource "aws_key_pair" "tf-key-pair" {
key_name = "tf-key-pair"
public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}

resource "local_file" "tf-key" {
content  = tls_private_key.rsa.private_key_pem
filename = "tf-key-pair"
}
