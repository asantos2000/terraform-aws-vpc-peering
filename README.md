# AWS VPC Terraform module

Terraform module which creates VPC Peering resources on AWS.

These types of resources are supported:

**Data**
* [Route Tables](https://www.terraform.io/docs/providers/aws/d/route_tables.html)
* [VPC](https://www.terraform.io/docs/providers/aws/d/vpc.html)

**Resources**
* [VPC Peering Connection](https://www.terraform.io/docs/providers/aws/r/vpc_peering.html)
* [Subnet](https://www.terraform.io/docs/providers/aws/r/subnet.html)
* [Route](https://www.terraform.io/docs/providers/aws/r/route.html)
* [Route table](https://www.terraform.io/docs/providers/aws/r/route_table.html)

## Usage (hcl)

```json
provider "aws" {
  region = "us-west-2"
}

data "aws_caller_identity" "current" {}

module "vpc_peering" {
  source = "../tf/vpc_peering"

  name = "VPC Peering entre vpc1 e kdop"

  peer_owner_id = "${data.aws_caller_identity.current.account_id}"
  # Requester: VPC-A
  requester_vpc_id = "vpc-0633f5b01ce5e5b4a"

  # Accepter: VPC-B
  accepter_vpc_id =  "vpc-0dd594d777b886a91"

  tags = {
    Owner       = "system-team"
    Environment = "producao"
    Name        = "kdop-vpc2kdop-vpc-default"
  }
}
```

## Terraform version

Terraform version 0.10.3 or newer is required for this module to work.

## Examples

* [VPC-A](/../../VPC-A)
* [VPC-B](/../../VPC-A)
* [vpc_a_2_vpc_b](/../../vpc_a_2_vpc_b)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| peer_owner_id | AWS account ID of requester | string | | yes |
| name | Name of VPC peering | string | | yes |
| requester_vpc_id | Requester VPC id | string | | yes |
| accepter_vpc_id | Accepter VPC id | string | | yes |
| create_vpc_peering | Enable VPC peering creation | boolean | true | yes |
| tags| A map of tags to add to all resources | map | | yes |

## Outputs

| Name | Description |
|------|-------------|
| peer_owner_id | The requester account id |
| peer_vpc_id | The VPC Peer ID |

## References

* [Github: example-terraform-aws-vpc-peering](https://github.com/nicksantamaria/example-terraform-aws-vpc-peering)
* [Terraform Registry: vpc-peering](https://registry.terraform.io/modules/thomasbiddle/vpc-peering/aws/1.0.1)

## License

Apache 2 Licensed. See LICENSE for full details.
