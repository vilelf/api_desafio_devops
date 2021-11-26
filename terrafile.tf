provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "vilelf-tfstates"
    key    = "api_desafio_devops/terraform.tfstate"
  }
}


module "groundwork" {
  source = "./modules/groundwork"
}

module "ecs" {
  source = "./modules/ecs"
}

