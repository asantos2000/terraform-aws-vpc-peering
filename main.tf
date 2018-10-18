/**
 * Obtem dados das VPCs passsadas como parametro.
 */
data "aws_route_tables" "requester_routes" {
  vpc_id = "${var.requester_vpc_id}"
}

data "aws_route_tables" "accepter_routes" {
  vpc_id = "${var.accepter_vpc_id}"
}

data "aws_vpc" "vpc_requester" {
  id = "${var.requester_vpc_id}"
}

data "aws_vpc" "vpc_accepter" {
  id = "${var.accepter_vpc_id}"
}
/**
 * VPC peering connection.
 *
 * Establishes a relationship resource between the "requester" and "accepter" VPC.
 */
resource "aws_vpc_peering_connection" "requester2accepter" {
  count = "${var.create_vpc_peering ? 1 : 0}"

  peer_owner_id = "${var.peer_owner_id}"
  peer_vpc_id = "${var.accepter_vpc_id}"
  vpc_id = "${var.requester_vpc_id}"
  
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = "${merge(map("Name", format("%s", var.name)), var.tags)}"
}

/**
 * VPC peering route table.
 *
 * Adiciona o VPC peering nas tabelas de rotas associadas as subnets.
 */
resource "aws_route" "requester" {
  count                     = "${length(data.aws_route_tables.requester_routes.ids)}"
  route_table_id            = "${data.aws_route_tables.requester_routes.ids[count.index]}"
  destination_cidr_block    = "${data.aws_vpc.vpc_accepter.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.requester2accepter.id}"
}

resource "aws_route" "accepter" {
  count                     = "${length(data.aws_route_tables.accepter_routes.ids)}"
  route_table_id            = "${data.aws_route_tables.accepter_routes.ids[count.index]}"
  destination_cidr_block    = "${data.aws_vpc.vpc_requester.cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.requester2accepter.id}"
}