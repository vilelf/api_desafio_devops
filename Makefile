cnf ?= .env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# Get the latest tag
TAG=$(shell git describe --tags --abbrev=0)
GIT_COMMIT=$(shell git log -1 --format=%h)
TERRAFORM_VERSION=1.0.0

up:
	docker compose up -d
	open http://localhost:8000

build: 
	docker compose build

down:
	docker compose down

terraform-init:
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) init -upgrade=true

terraform-plan:
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_tag=latest -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) plan -out=tfplan

terraform-apply:
	docker run --rm -v $$PWD:/app -v $$HOME/.ssh/:/root/.ssh/ -w /app/ -e TF_VAR_tag=latest -e AWS_ACCESS_KEY_ID=$$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$$AWS_SECRET_ACCESS_KEY hashicorp/terraform:$(TERRAFORM_VERSION) apply "tfplan"