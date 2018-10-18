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