# terraform-aws-global-vars

## This module is to reference global variables

This module is to reference global variables across modules and applications in AWS.

References for the following resources
- 
- 

## Usage

```hcl

module "Global-Vars" { 
    source              = "../../Modules/Global-Vars"
    environment         = "${var.environment}"
    region              = "${var.region}"
}

```

## Inputs

### environment
This is the lifecycle of the application. Eg. test,dev,qa,uat,prod

### region
This is the region of the application. Eg. us-east-1



## Outputs

### account_id
This is the account number currently being deployed to.

### vpc_cidr_block
This is the VPC cidr block output for the environment requested.

### subnet_id_map
This output returns a map of subnet ids of the requested subnet.

### vpc_id
This is the vpc id of the requested environment.

### welldyne_public_ips
This returns the list of WellDyneRx public IPs.

### wildcard_certificate
This returns the wildcard certificate arn from the requested environment.

### r53_zone_id
This output returns the zone id of the requested environment.

### route53_zone
This output returns the zone name of the requested environment.

### location
This outputs the region short name for tagging resources.
