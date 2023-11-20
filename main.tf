# -------------------------------------------------------
# Copyright (c) [2022] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Module to deploy the basic vpc structure
# -------------------------------------------------------
# Nadège LEMPERIERE, @20 november 2021
# Latest revision: 20 november 2021
# -------------------------------------------------------

# -------------------------------------------------------
# Create the global network for technogix
# -------------------------------------------------------
resource "aws_vpc" "vpc" {

	cidr_block          	= var.cidr
    enable_dns_support  	= true
	enable_dns_hostnames	= true

	tags = {
		Name           	= "${var.project}.${var.environment}.${var.module}.vpc"
		Environment     = var.environment
		Owner   		= var.email
		Project   		= var.project
		Version 		= var.git_version
		Module  		= var.module
	}
}

# -------------------------------------------------------
# Create the default vpc route table
# -------------------------------------------------------
resource "aws_default_route_table" "vpc_route_table" {

	default_route_table_id	= aws_vpc.vpc.default_route_table_id

    tags = {
		Name           	= "${var.project}.${var.environment}.${var.module}.vpc.routes"
		Environment     = var.environment
		Owner   		= var.email
		Project   		= var.project
		Version 		= var.git_version
		Module  		= var.module
	}
}


# -------------------------------------------------------
# Create default vpc access control list
# -------------------------------------------------------
resource "aws_default_network_acl" "vpc_acl" {

  	default_network_acl_id  = aws_vpc.vpc.default_network_acl_id

 	tags = {
		Name           	= "${var.project}.${var.environment}.${var.module}.vpc.nacl"
		Environment     = var.environment
		Owner   		= var.email
		Project   		= var.project
		Version 		= var.git_version
		Module  		= var.module
	}
}

# -------------------------------------------------------
# Create default vpc security group
# -------------------------------------------------------
resource "aws_default_security_group" "vpc_sg" {

  	vpc_id  = aws_vpc.vpc.id

 	tags = {
		Name           	= "${var.project}.${var.environment}.${var.module}.vpc.nsg"
		Environment     = var.environment
		Owner   		= var.email
		Project   		= var.project
		Version 		= var.git_version
		Module  		= var.module
	}
}

# -------------------------------------------------------
# Configure cloudwatch logging for the virtual network
# -------------------------------------------------------
resource "aws_flow_log" "cloudwatch" {

	count 					= (var.logging == null) ? 0 : 1

	iam_role_arn    		= var.logging.role
  	log_destination_type 	= "cloud-watch-logs"
  	log_destination 		= var.logging.loggroup
	traffic_type    		= "ALL"
  	vpc_id          		= aws_vpc.vpc.id

  	tags = {
		Name           	= "${var.project}.${var.environment}.${var.module}.vpc.logs.cloudwatch"
		Environment     = var.environment
		Owner   		= var.email
		Project   		= var.project
		Version 		= var.git_version
		Module  		= var.module
	}
}

# -------------------------------------------------------
# Configure s3 logging for the virtual network
# -------------------------------------------------------
resource "aws_flow_log" "s3" {

	count 					= (var.logging == null) ? 0 : 1

	log_destination_type 	= "s3"
  	log_destination 		= var.logging.s3
  	traffic_type    		= "ALL"
  	vpc_id          		= aws_vpc.vpc.id

  	tags = {
		Name           	= "${var.project}.${var.environment}.${var.module}.vpc.logs.s3"
		Environment     = var.environment
		Owner   		= var.email
		Project   		= var.project
		Version 		= var.git_version
		Module  		= var.module
	}
}
