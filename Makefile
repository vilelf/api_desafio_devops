cnf ?= .env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# Get the latest tag
TAG=$(shell git describe --tags --abbrev=0)
GIT_COMMIT=$(shell git log -1 --format=%h)
TERRAFORM_VERSION=1.0.0

build: 
	docker build -t api_desafio_devops .

up:
	docker run -it 80:80 api_desafio_devops

terraform-init:
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) init -upgrade=true

terraform-plan:
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_tag=latest -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) plan -out=tfplan

terraform-apply:
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_tag=latest -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) apply "tfplan"

terraform-destroy:
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_tag=latest -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) destroy -auto-approve
