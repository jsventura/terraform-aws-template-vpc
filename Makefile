OWNER    = punkerside
PROJECT  = vpc
ENV      = demo

CIDR_BLOCK = 10.1.0.0/16
CIDR_PRI   = ["10.1.0.0/22","10.1.4.0/22","10.1.8.0/22"]
CIDR_PUB   = ["10.1.12.0/22","10.1.16.0/22","10.1.20.0/22"]
AWS_REGION = us-east-1

quickstart:
	@make init
	@make apply

init:
	export AWS_DEFAULT_REGION="$(AWS_REGION)" && \
	cd terraform/ && terraform init

apply:
	export AWS_DEFAULT_REGION="$(AWS_REGION)" && \
	cd terraform/ && terraform apply \
	  -var 'owner=$(OWNER)' \
	  -var 'env=$(ENV)' \
	  -var 'cidr_block=$(CIDR_BLOCK)' \
	  -var 'cidr_pub=$(CIDR_PUB)' \
	  -var 'cidr_pri=$(CIDR_PRI)' \
	-auto-approve \
	-lock-timeout=300s

destroy:
	export AWS_DEFAULT_REGION="$(AWS_REGION)" && \
	cd terraform/ && terraform destroy \
	  -var 'owner=$(OWNER)' \
	  -var 'env=$(ENV)' \
	  -var 'cidr_block=$(CIDR_BLOCK)' \
	  -var 'cidr_pub=$(CIDR_PUB)' \
	  -var 'cidr_pri=$(CIDR_PRI)' \
	-auto-approve \
	-lock-timeout=300s