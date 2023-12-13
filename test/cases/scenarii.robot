# -------------------------------------------------------
# Copyright (c) [2022] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Robotframework test suite for module
# -------------------------------------------------------
# Nadège LEMPERIERE, @12 november 2021
# Latest revision: 12 november 2021
# -------------------------------------------------------


*** Settings ***
Documentation   A test case to check virtual private cloud creation
Library         aws_iac_keywords.terraform
Library         aws_iac_keywords.keepass
Library         aws_iac_keywords.ec2
Library         aws_iac_keywords.s3
Library         ../keywords/data.py
Library         OperatingSystem

*** Variables ***
${KEEPASS_DATABASE}                 ${vault_database}
${KEEPASS_KEY_ENV}                  ${vault_key_env}
${KEEPASS_PRINCIPAL_KEY_ENTRY}      /aws/aws-principal-access-key
${REGION}                           eu-west-1

*** Test Cases ***
Prepare environment
    [Documentation]         Retrieve principal credential from database and initialize python tests keywords
    ${keepass_key}          Get Environment Variable          ${KEEPASS_KEY_ENV}
    ${principal_access}     Load Keepass Database Secret      ${KEEPASS_DATABASE}     ${keepass_key}  ${KEEPASS_PRINCIPAL_KEY_ENTRY}            username
    ${principal_secret}     Load Keepass Database Secret      ${KEEPASS_DATABASE}     ${keepass_key}  ${KEEPASS_PRINCIPAL_KEY_ENTRY}            password
    Initialize Terraform    ${REGION}   ${principal_access}   ${principal_secret}
    Initialize EC2          None        ${principal_access}   ${principal_secret}    ${REGION}
    Initialize S3           None        ${principal_access}   ${principal_secret}    ${REGION}

Create Standard Vpc
    [Documentation]         Create Standard VPC
    Launch Terraform Deployment                 ${CURDIR}/../data/standard
    ${states}   Load Terraform States           ${CURDIR}/../data/standard
    ${specs}    Load Standard Test Data         ${states['test']['outputs']['vpc']['value']['id']}   ${states['test']['outputs']['vpc']['value']['acl']['id']}   ${states['test']['outputs']['vpc']['value']['route']['id']}    ${states['test']['outputs']['vpc']['value']['security_group']['id']}
    VPC Shall Exist And Match                   ${specs['vpc']}
    NACL Shall Exist And Match                  ${specs['nacl']}
    Route Table Shall Exist And Match           ${specs['route']}
    Security Group Shall Exist And Match        ${specs['security_group']}
    [Teardown]  Destroy Terraform Deployment    ${CURDIR}/../data/standard


Create Vpc With Logging
    [Documentation]         Create VPC With Logging
    Launch Terraform Deployment                 ${CURDIR}/../data/logging
    ${states}   Load Terraform States           ${CURDIR}/../data/logging
    ${specs}    Load Logging Test Data          ${states['test']['outputs']['vpc']['value']['id']}   ${states['test']['outputs']['vpc']['value']['acl']['id']}   ${states['test']['outputs']['vpc']['value']['route']['id']}    ${states['test']['outputs']['vpc']['value']['security_group']['id']}    ${states['test']['outputs']['vpc']['value']['logging']}
    VPC Shall Exist And Match                   ${specs['vpc']}
    NACL Shall Exist And Match                  ${specs['nacl']}
    Route Table Shall Exist And Match           ${specs['route']}
    Security Group Shall Exist And Match        ${specs['security_group']}
    Flow Logs Shall Exist And Match             ${specs['flows']}
    Empty S3 Bucket                             ${states['test']['outputs']['vpc']['value']['logging']['s3']['name']}
    [Teardown]  Destroy Terraform Deployment    ${CURDIR}/../data/logging
