# -------------------------------------------------------
# Copyright (c) [2022] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Module to deploy the basic vpc structure
# -------------------------------------------------------
# Nadège LEMPERIERE, @20 november 2021
# Latest revision: 20 november 2021
# -------------------------------------------------------

output "vpc" {
    value = {
        id              = aws_vpc.vpc.id
        arn             = aws_vpc.vpc.arn
        cidr            = aws_vpc.vpc.cidr_block
    }
}
output "route" {
    value = {
        id      = aws_default_route_table.vpc_route_table.id
        arn     = aws_default_route_table.vpc_route_table.arn
    }
}

output "nacl" {
    value = {
        id      = aws_default_network_acl.vpc_acl.id
        arn     = aws_default_network_acl.vpc_acl.arn
    }
}

output "security_group" {
    value = {
        id      = aws_default_security_group.vpc_sg.id
        arn     = aws_default_security_group.vpc_sg.arn
        name    = aws_default_security_group.vpc_sg.name
    }
}
