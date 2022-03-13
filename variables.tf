# -------------------------------------------------------
# TECHNOGIX
# -------------------------------------------------------
# Copyright (c) [2021] Technogix.io
# All rights reserved
# -------------------------------------------------------
# Module to deploy the basic vpc structure
# -------------------------------------------------------
# Nadège LEMPERIERE, @20 november 2021
# Latest revision: 20 november 2021
# -------------------------------------------------------

# -------------------------------------------------------
# Contact e-mail for this deployment
# -------------------------------------------------------
variable "email" {
	type 	= string
}

# -------------------------------------------------------
# Environment for this deployment (prod, preprod, ...)
# -------------------------------------------------------
variable "environment" {
	type 	= string
}

# -------------------------------------------------------
# Topic context for this deployment
# -------------------------------------------------------
variable "project" {
	type    = string
}
variable "module" {
	type 	= string
}

# -------------------------------------------------------
# Solution version
# -------------------------------------------------------
variable "git_version" {
	type    = string
	default = "unmanaged"
}

# --------------------------------------------------------
# VPC configuration
# --------------------------------------------------------
variable "cidr" {
	type = string
}

# --------------------------------------------------------
# Logging configuration
# --------------------------------------------------------
variable "logging" {
	type 	= object({
		s3			= string
		loggroup 	= string
		role 		= string
	})
	default = null
}
