# -------------------------------------------------------
# Copyright (c) [2022] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Keywords to create data for module test
# -------------------------------------------------------
# Nadège LEMPERIERE, @13 november 2021
# Latest revision: 13 november 2021
# -------------------------------------------------------

# System includes
from json import load, dumps

# Robotframework includes
from robot.libraries.BuiltIn import BuiltIn, _Misc
from robot.api import logger as logger
from robot.api.deco import keyword
ROBOT = False

# ip address manipulation
from ipaddress import IPv4Network

@keyword('Load Standard Test Data')
def load_standard_test_data(vpc, nacl, route, sg) :

    result = {}

    result['vpc'] = []
    result['vpc'].append({})
    result['vpc'][0]['name'] = 'standard'
    result['vpc'][0]['data'] = {}
    result['vpc'][0]['data']['CidrBlock'] = '10.100.0.0/26'
    result['vpc'][0]['data']['State'] = 'available'
    result['vpc'][0]['data']['IsDefault'] = False
    result['vpc'][0]['data']['VpcId'] = vpc
    result['vpc'][0]['data']['Tags'] = []
    result['vpc'][0]['data']['Tags'].append({'Key'          : 'Version'     , 'Value' : 'test'})
    result['vpc'][0]['data']['Tags'].append({'Key'          : 'Project'     , 'Value' : 'test'})
    result['vpc'][0]['data']['Tags'].append({'Key'          : 'Module'      , 'Value' : 'test'})
    result['vpc'][0]['data']['Tags'].append({'Key'          : 'Environment' , 'Value' : 'test'})
    result['vpc'][0]['data']['Tags'].append({'Key'          : 'Owner'       , 'Value' : 'moi.moi@moi.fr'})
    result['vpc'][0]['data']['Tags'].append({'Key'          : 'Name'        , 'Value' : 'test.test.test.vpc'})

    result['nacl'] =  []
    result['nacl'].append({})
    result['nacl'][0]['name'] = 'standard'
    result['nacl'][0]['data'] = {}
    result['nacl'][0]['data']['VpcId'] = vpc
    result['nacl'][0]['data']['NetworkAclId'] = nacl
    result['nacl'][0]['data']['Tags'] = []
    result['nacl'][0]['data']['Tags'].append({'Key'          : 'Version'     , 'Value' : 'test'})
    result['nacl'][0]['data']['Tags'].append({'Key'          : 'Project'     , 'Value' : 'test'})
    result['nacl'][0]['data']['Tags'].append({'Key'          : 'Module'      , 'Value' : 'test'})
    result['nacl'][0]['data']['Tags'].append({'Key'          : 'Environment' , 'Value' : 'test'})
    result['nacl'][0]['data']['Tags'].append({'Key'          : 'Owner'       , 'Value' : 'moi.moi@moi.fr'})
    result['nacl'][0]['data']['Tags'].append({'Key'          : 'Name'        , 'Value' : 'test.test.test.vpc.nacl'})
    result['nacl'][0]['data']['VpcId'] = vpc
    result['nacl'][0]['data']['IsDefault'] = True
    result['nacl'][0]['data']['Entries'] = []

    result['route'] =  []
    result['route'].append({})
    result['route'][0]['name'] = 'standard'
    result['route'][0]['data'] = {}
    result['route'][0]['data']['VpcId'] = vpc
    result['route'][0]['data']['RouteTableId'] = route
    result['route'][0]['data']['Routes'] = [
        {"DestinationCidrBlock": "10.100.0.0/26", "GatewayId": "local", "Origin": "CreateRouteTable", "State": "active"}
    ]
    result['route'][0]['data']['Associations'] = []
    result['route'][0]['data']['Associations'].append({})
    result['route'][0]['data']['Associations'][0]['Main'] = True
    result['route'][0]['data']['Associations'][0]['AssociationState'] = {'State': 'associated'}
    result['route'][0]['data']['Tags'] = []
    result['route'][0]['data']['Tags'].append({'Key'          : 'Version'     , 'Value' : 'test'})
    result['route'][0]['data']['Tags'].append({'Key'          : 'Project'     , 'Value' : 'test'})
    result['route'][0]['data']['Tags'].append({'Key'          : 'Module'      , 'Value' : 'test'})
    result['route'][0]['data']['Tags'].append({'Key'          : 'Environment' , 'Value' : 'test'})
    result['route'][0]['data']['Tags'].append({'Key'          : 'Owner'       , 'Value' : 'moi.moi@moi.fr'})
    result['route'][0]['data']['Tags'].append({'Key'          : 'Name'        , 'Value' : 'test.test.test.vpc.routes'})

    result['security_group'] =  []
    result['security_group'].append({})
    result['security_group'][0]['name'] = 'standard'
    result['security_group'][0]['data'] = {}
    result['security_group'][0]['data']['GroupName'] = 'default'
    result['security_group'][0]['data']['IpPermissions'] = []
    result['security_group'][0]['data']['GroupId'] = sg
    result['security_group'][0]['data']['IpPermissionsEgress'] = []
    result['security_group'][0]['data']['VpcId'] = vpc
    result['security_group'][0]['data']['Tags'] = []
    result['security_group'][0]['data']['Tags'].append({'Key'          : 'Version'     , 'Value' : 'test'})
    result['security_group'][0]['data']['Tags'].append({'Key'          : 'Project'     , 'Value' : 'test'})
    result['security_group'][0]['data']['Tags'].append({'Key'          : 'Module'      , 'Value' : 'test'})
    result['security_group'][0]['data']['Tags'].append({'Key'          : 'Environment' , 'Value' : 'test'})
    result['security_group'][0]['data']['Tags'].append({'Key'          : 'Owner'       , 'Value' : 'moi.moi@moi.fr'})
    result['security_group'][0]['data']['Tags'].append({'Key'          : 'Name'        , 'Value' : 'test.test.test.vpc.nsg'})

    logger.debug(dumps(result))

    return result


@keyword('Load Logging Test Data')
def load_logging_test_data(vpc, nacl, route, sg, logging) :

    result = {}

    result['vpc'] = []
    result['vpc'].append({})
    result['vpc'][0]['name'] = 'logging'
    result['vpc'][0]['data'] = {}
    result['vpc'][0]['data']['CidrBlock'] = '10.100.0.0/26'
    result['vpc'][0]['data']['State'] = 'available'
    result['vpc'][0]['data']['IsDefault'] = False
    result['vpc'][0]['data']['VpcId'] = vpc
    result['vpc'][0]['data']['Tags'] = []
    result['vpc'][0]['data']['Tags'].append({'Key'          : 'Version'     , 'Value' : 'test'})
    result['vpc'][0]['data']['Tags'].append({'Key'          : 'Project'     , 'Value' : 'test'})
    result['vpc'][0]['data']['Tags'].append({'Key'          : 'Module'      , 'Value' : 'test'})
    result['vpc'][0]['data']['Tags'].append({'Key'          : 'Environment' , 'Value' : 'test'})
    result['vpc'][0]['data']['Tags'].append({'Key'          : 'Owner'       , 'Value' : 'moi.moi@moi.fr'})
    result['vpc'][0]['data']['Tags'].append({'Key'          : 'Name'        , 'Value' : 'test.test.test.vpc'})

    result['nacl'] =  []
    result['nacl'].append({})
    result['nacl'][0]['name'] = 'logging'
    result['nacl'][0]['data'] = {}
    result['nacl'][0]['data']['VpcId'] = vpc
    result['nacl'][0]['data']['NetworkAclId'] = nacl
    result['nacl'][0]['data']['Tags'] = []
    result['nacl'][0]['data']['Tags'].append({'Key'          : 'Version'     , 'Value' : 'test'})
    result['nacl'][0]['data']['Tags'].append({'Key'          : 'Project'     , 'Value' : 'test'})
    result['nacl'][0]['data']['Tags'].append({'Key'          : 'Module'      , 'Value' : 'test'})
    result['nacl'][0]['data']['Tags'].append({'Key'          : 'Environment' , 'Value' : 'test'})
    result['nacl'][0]['data']['Tags'].append({'Key'          : 'Owner'       , 'Value' : 'moi.moi@moi.fr'})
    result['nacl'][0]['data']['Tags'].append({'Key'          : 'Name'        , 'Value' : 'test.test.test.vpc.nacl'})
    result['nacl'][0]['data']['VpcId'] = vpc
    result['nacl'][0]['data']['IsDefault'] = True
    result['nacl'][0]['data']['Entries'] = []

    result['route'] =  []
    result['route'].append({})
    result['route'][0]['name'] = 'logging'
    result['route'][0]['data'] = {}
    result['route'][0]['data']['VpcId'] = vpc
    result['route'][0]['data']['RouteTableId'] = route
    result['route'][0]['data']['Routes'] = [
        {"DestinationCidrBlock": "10.100.0.0/26", "GatewayId": "local", "Origin": "CreateRouteTable", "State": "active"}
    ]
    result['route'][0]['data']['Associations'] = []
    result['route'][0]['data']['Associations'].append({})
    result['route'][0]['data']['Associations'][0]['Main'] = True
    result['route'][0]['data']['Associations'][0]['AssociationState'] = {'State': 'associated'}
    result['route'][0]['data']['Tags'] = []
    result['route'][0]['data']['Tags'].append({'Key'          : 'Version'     , 'Value' : 'test'})
    result['route'][0]['data']['Tags'].append({'Key'          : 'Project'     , 'Value' : 'test'})
    result['route'][0]['data']['Tags'].append({'Key'          : 'Module'      , 'Value' : 'test'})
    result['route'][0]['data']['Tags'].append({'Key'          : 'Environment' , 'Value' : 'test'})
    result['route'][0]['data']['Tags'].append({'Key'          : 'Owner'       , 'Value' : 'moi.moi@moi.fr'})
    result['route'][0]['data']['Tags'].append({'Key'          : 'Name'        , 'Value' : 'test.test.test.vpc.routes'})

    result['security_group'] =  []
    result['security_group'].append({})
    result['security_group'][0]['name'] = 'logging'
    result['security_group'][0]['data'] = {}
    result['security_group'][0]['data']['GroupName'] = 'default'
    result['security_group'][0]['data']['IpPermissions'] = []
    result['security_group'][0]['data']['GroupId'] = sg
    result['security_group'][0]['data']['IpPermissionsEgress'] = []
    result['security_group'][0]['data']['VpcId'] = vpc
    result['security_group'][0]['data']['Tags'] = []
    result['security_group'][0]['data']['Tags'].append({'Key'          : 'Version'     , 'Value' : 'test'})
    result['security_group'][0]['data']['Tags'].append({'Key'          : 'Project'     , 'Value' : 'test'})
    result['security_group'][0]['data']['Tags'].append({'Key'          : 'Module'      , 'Value' : 'test'})
    result['security_group'][0]['data']['Tags'].append({'Key'          : 'Environment' , 'Value' : 'test'})
    result['security_group'][0]['data']['Tags'].append({'Key'          : 'Owner'       , 'Value' : 'moi.moi@moi.fr'})
    result['security_group'][0]['data']['Tags'].append({'Key'          : 'Name'        , 'Value' : 'test.test.test.vpc.nsg'})

    result['flows'] = []
    result['flows'].append({})
    result['flows'][0]['name'] = 'cloudwatch'
    result['flows'][0]['data'] = {}
    result['flows'][0]['data']['LogDestinationType'] = 'cloud-watch-logs'
    result['flows'][0]['data']['LogGroupName'] = logging['loggroup']['name']
    result['flows'][0]['data']['LogDestinationType'] = 'cloud-watch-logs'
    result['flows'][0]['data']['ResourceId'] = vpc
    result['flows'][0]['data']['Tags'] = []
    result['flows'][0]['data']['Tags'].append({'Key'          : 'Version'     , 'Value' : 'test'})
    result['flows'][0]['data']['Tags'].append({'Key'          : 'Project'     , 'Value' : 'test'})
    result['flows'][0]['data']['Tags'].append({'Key'          : 'Module'      , 'Value' : 'test'})
    result['flows'][0]['data']['Tags'].append({'Key'          : 'Environment' , 'Value' : 'test'})
    result['flows'][0]['data']['Tags'].append({'Key'          : 'Owner'       , 'Value' : 'moi.moi@moi.fr'})
    result['flows'][0]['data']['Tags'].append({'Key'          : 'Name'        , 'Value' : 'test.test.test.vpc.logs.cloudwatch'})
    result['flows'].append({})
    result['flows'][1]['name'] = 's3'
    result['flows'][1]['data'] = {}
    result['flows'][1]['data']['LogDestinationType'] = 's3'
    result['flows'][1]['data']['ResourceId'] = vpc
    result['flows'][1]['data']['Tags'] = []
    result['flows'][1]['data']['Tags'].append({'Key'          : 'Version'     , 'Value' : 'test'})
    result['flows'][1]['data']['Tags'].append({'Key'          : 'Project'     , 'Value' : 'test'})
    result['flows'][1]['data']['Tags'].append({'Key'          : 'Module'      , 'Value' : 'test'})
    result['flows'][1]['data']['Tags'].append({'Key'          : 'Environment' , 'Value' : 'test'})
    result['flows'][1]['data']['Tags'].append({'Key'          : 'Owner'       , 'Value' : 'moi.moi@moi.fr'})
    result['flows'][1]['data']['Tags'].append({'Key'          : 'Name'        , 'Value' : 'test.test.test.vpc.logs.s3'})

    logger.debug(dumps(result))

    return result
