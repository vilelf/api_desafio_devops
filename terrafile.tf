provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "vilelf-tfstates"
    key    = "api_desafio_devops/terraform.tfstate"
    region = "us-east-1"
  }
}

module "ecs" {
  source = "./modules/ecs"
}

module "ecr" {
  source = "./modules/ecr"
}