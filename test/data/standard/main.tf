# -------------------------------------------------------
# Copyright (c) [2022] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Simple deployment for testing
# -------------------------------------------------------
# Nadège LEMPERIERE, @20 november 2021
# Latest revision: 20 november 2021
# -------------------------------------------------------

# -------------------------------------------------------
# Create permissions using the current module
# -------------------------------------------------------
module "network" {
    source      = "../../../"
    email 		= "moi.moi@moi.fr"
	project 	= "test"
	environment = "test"
	module 		= "test"
	git_version = "test"
	cidr		= "10.100.0.0/26"
}

# -------------------------------------------------------
# Terraform configuration
# -------------------------------------------------------
provider "aws" {
	region		= var.region
	access_key 	= var.access_key
	secret_key	= var.secret_key
}

terraform {
	required_version = ">=1.0.8"
	backend "local"	{
		path="terraform.tfstate"
	}
}

# -------------------------------------------------------
# AWS configuration for this deployment
# -------------------------------------------------------
variable "region" {
	type    = string
}

# -------------------------------------------------------
# AWS credentials
# -------------------------------------------------------
variable "access_key" {
	type    	= string
	sensitive 	= true
}
variable "secret_key" {
	type    	= string
	sensitive 	= true
}

# -------------------------------------------------------
# Test outputs
# -------------------------------------------------------
output "vpc" {
	value = {
		id          = module.network.vpc.id
		arn         = module.network.vpc.arn
    	cidr        = module.network.vpc.cidr
    	route       = {
        	id      = module.network.route.id
        	arn     = module.network.route.arn
    	}
    	acl             = {
        	id      = module.network.nacl.id
        	arn     = module.network.nacl.arn
    	}
    	security_group  = {
        	id      = module.network.security_group.id
        	arn     = module.network.security_group.arn
        	name    = module.network.security_group.name
    	}
  	}
}