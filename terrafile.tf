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

  ecr_repo = module.ecr.aws_ecr_repository.repo.repository_url
}

module "ecr" {
  source = "./modules/ecr"
}

variable "tag" {
  type = string
}