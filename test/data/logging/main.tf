# -------------------------------------------------------
# TECHNOGIX
# -------------------------------------------------------
# Copyright (c) [2022] Technogix SARL
# All rights reserved
# -------------------------------------------------------
# Simple deployment for testing
# -------------------------------------------------------
# Nadège LEMPERIERE, @20 november 2021
# Latest revision: 20 november 2021
# -------------------------------------------------------

# -------------------------------------------------------
# Create the log group to gather logs
# -------------------------------------------------------
resource "random_string" "random1" {
	length		= 32
	special		= false
	upper 		= false
}
resource "aws_cloudwatch_log_group" "test" {
	name = random_string.random1.result
	retention_in_days = 7
}

# -------------------------------------------------------
# Create the s3 bucket
# -------------------------------------------------------
resource "random_string" "random2" {
	length		= 32
	special		= false
	upper 		= false
}
resource "aws_s3_bucket" "test" {
	bucket = random_string.random2.result
}

# -----------------------------------------------------------
# Create role for flow logs to write in cloudwatch
# -----------------------------------------------------------
resource "aws_iam_role" "test" {

  	name = "test"
  	assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
   			{
      			Effect 		= "Allow"
      			Principal 	=  {
					"Service": [ "delivery.logs.amazonaws.com", "vpc-flow-logs.amazonaws.com"]
				}
    			Action 		= "sts:AssumeRole"
    		}
  		]
	})
}

# -----------------------------------------------------------
# Create associated role policy that enables flow to address
# -----------------------------------------------------------
resource "aws_iam_role_policy" "test" {

  	name = "test"
  	role = aws_iam_role.test.id

  	policy = jsonencode({
  		Version = "2012-10-17",
  		Statement = [
    		{
      			Effect 	= "Allow"
      			Action  = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:DescribeLogGroups",  "logs:DescribeLogStreams"]
      			Resource: "${aws_cloudwatch_log_group.test.arn}:*"
    		},
    		{
      			Effect 	= "Allow"
      			Action = ["logs:PutLogEvents"]
      			Resource = "${aws_cloudwatch_log_group.test.arn}:*"
    		}
  		]
	})
}

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
	logging 	= {
		loggroup	= aws_cloudwatch_log_group.test.arn
		s3 		 	= aws_s3_bucket.test.arn
		role	 	= aws_iam_role.test.arn
	}
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
		logging			= {
			loggroup = {
				arn 	= aws_cloudwatch_log_group.test.arn
				name 	= aws_cloudwatch_log_group.test.name
			}
			s3 		 = {
				id 		= aws_s3_bucket.test.id
				name 	= aws_s3_bucket.test.bucket
			}
			role	 = aws_iam_role.test.arn
		}
  	}
}