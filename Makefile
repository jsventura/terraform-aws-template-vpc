OWNER   = punkerside
PROJECT = vpc
ENV     = lab

CIDR_BLOCK = 10.1.0.0/16
CIDR_PUB   = ["10.1.0.0/24","10.1.1.0/24","10.1.2.0/24"]
CIDR_PRI   = ["10.1.3.0/24","10.1.4.0/24","10.1.5.0/24"]
AWS_REGION = us-east-1

quickstart:
	@make init
	@make apply

delete:
	@make destroy
	@rm -rf terraform/.terraform/

init:
	export AWS_DEFAULT_REGION="$(AWS_REGION)" && \
	cd terraform/ && \
	terraform init \
	  -backend-config bucket='$(OWNER)-prod-terraform' \
	  -backend-config key='state/$(PROJECT)/$(ENV)/terraform.tfstate' \
	  -backend-config region='us-east-1'

apply:
	export AWS_DEFAULT_REGION="$(AWS_REGION)" && \
	cd terraform/ && \
	terraform apply \
	  -var 'owner=$(OWNER)' \
	  -var 'env=$(ENV)' \
	  -var 'cidr_block=$(CIDR_BLOCK)' \
	  -var 'cidr_pub=$(CIDR_PUB)' \
	  -var 'cidr_pri=$(CIDR_PRI)' \
	-auto-approve \
	-lock-timeout=30s

destroy:
	export AWS_DEFAULT_REGION="$(AWS_REGION)" && \
	cd terraform/ && \
	terraform destroy \
	  -var 'owner=$(OWNER)' \
	  -var 'env=$(ENV)' \
	  -var 'cidr_block=$(CIDR_BLOCK)' \
	  -var 'cidr_pub=$(CIDR_PUB)' \
	  -var 'cidr_pri=$(CIDR_PRI)' \
	-auto-approve \
	-lock-timeout=3s

validate:
	export AWS_DEFAULT_REGION="$(AWS_REGION)" && \
	cd terraform/ && \
	terraform validate -check-variables=true \
	  -var 'owner=$(OWNER)' \
	  -var 'env=$(ENV)' \
	  -var 'cidr_block=$(CIDR_BLOCK)' \
	  -var 'cidr_pub=$(CIDR_PUB)' \
	  -var 'cidr_pri=$(CIDR_PRI)' \

update:
	export AWS_DEFAULT_REGION="$(AWS_REGION)" && \
	cd terraform/ && \
	terraform get -update